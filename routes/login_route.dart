import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noname/main.dart';

class LoginRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginInfo>(
      builder: (BuildContext context, LoginInfo loginInfo, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Login", style: TextStyle(fontSize: 25.0, fontFamily: "IBMPlexSans")),
            titleSpacing: 20.0,
            backgroundColor: Color(0xff000070)
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Title(),
                LoginButton(),
                Padding(padding: const EdgeInsets.symmetric(vertical: 12.0)),
                Text("For first time users", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 15.0, color: Color(0xff000070))),
                RegisterButton()
              ],
            )
          )
        );
      },
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("RandPosts", style: TextStyle(fontFamily: "IBMPlexSans", color: Color(0xff000070), fontSize: 40.0, fontWeight: FontWeight.w600)),
      margin: const EdgeInsets.only(bottom: 190.0, top: 20.0)
    );
  }
}

class LoginButton extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _reference = Firestore.instance.collection("users");

  Future<void> _signIn(BuildContext context, LoginInfo loginInfo) async {
    final GoogleSignInAccount _googleSignInAccount = await loginInfo.signInGoogle();
    final GoogleSignInAuthentication _googleSignInAuth = await _googleSignInAccount.authentication;

    final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
      idToken: _googleSignInAuth.idToken,
      accessToken: _googleSignInAuth.accessToken
    );

    final AuthResult _authResult = await _firebaseAuth.signInWithCredential(_authCredential);
    final String _authUID = _authResult.user.uid;
    bool _uidPresence = false;

    await _reference.getDocuments().then((result) => result.documents.forEach((doc) {
      if(doc.documentID == _authUID) {
        print("UID found");
        _uidPresence = true;
        loginInfo.setUserData(doc.data["email"], doc.data["display_name"], doc.data["info"], doc.data["status"], doc.documentID);
      }
    }));

    if(_uidPresence) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Successful Login", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Colors.white)),
        backgroundColor: Color(0xff000070)
      ));
      print(loginInfo.userData);
      Future.delayed(Duration(seconds: 2), () => loginInfo.changeLoginStatus());
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Login failed, try registering first", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Colors.white)),
        backgroundColor: Color(0xff000070)
      ));
      loginInfo.signOutGoogle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginInfo>(
      builder: (BuildContext context, LoginInfo loginInfo, Widget child) {
        return RaisedButton(
          child: Text("Sign In with Google", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 22.0, color: Colors.white)),
          color: Color(0xff000070),
          padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
          onPressed: () => _signIn(context, loginInfo),
          elevation: 2.5
        );
      }
    );
  }
}

class RegisterButton extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _reference = Firestore.instance.collection("users");

  Future<void> _signUp(BuildContext context, LoginInfo loginInfo) async {
    final GoogleSignInAccount _googleSignInAccount = await loginInfo.signInGoogle();
    final GoogleSignInAuthentication _googleSignInAuth = await _googleSignInAccount.authentication;

    final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
      idToken: _googleSignInAuth.idToken,
      accessToken: _googleSignInAuth.accessToken
    );

    final AuthResult _authResult = await _firebaseAuth.signInWithCredential(_authCredential);
    final String _authUID = _authResult.user.uid;

    bool _uidPresence = false;

    await _reference.getDocuments().then((result) {
      for(var doc in result.documents) {
        if(doc.documentID == _authUID) {
          print("UID matched");
          _uidPresence = true;
        }
      }
    });

    if(!_uidPresence) {
      await _addDataToFirestore(_authResult.user, loginInfo);
      print("UserData added to firestore");
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Registration Successful", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Colors.white)),
        backgroundColor: Color(0xff000070),
      ));
      Future.delayed(Duration(seconds: 2), () => loginInfo.changeLoginStatus());
    }
    else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("User already registered, try Signing In", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Colors.white)),
        backgroundColor: Color(0xff000070),
      ));
    }
  }

  Future<void> _addDataToFirestore(FirebaseUser user, LoginInfo loginInfo) async {
    loginInfo.setUserData(user.email, user.displayName, "", "Started exploring RandPosts", user.uid);
    return await _reference.document(user.uid).setData({
      "email": user.email,
      "display_name": user.displayName,
      "phone_num": user.phoneNumber,
      "is_verified": user.isEmailVerified,
      "status": "Started exploring RandPosts",
      "info": "",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginInfo>(
      builder: (BuildContext context, LoginInfo loginInfo, Widget child) {
        return OutlineButton(
          child: Text("Register", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 22.0, color: Color(0xff000070))),
          borderSide: BorderSide(width: 2.0, color: Color(0xff000070)),
          highlightedBorderColor: Color(0xff000070),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
          onPressed: () => _signUp(context, loginInfo)
        );
      }
    );
  }
}