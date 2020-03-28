import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:noname/routes/home_route.dart";
import 'package:noname/routes/profile_route.dart';
import 'package:noname/routes/profile_edit_route.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginInfo(),
      child: MaterialApp(
        title: "Useless App",
        initialRoute: "/",
        routes: {
          "/": (context) => HomeRoute(),
          "/profile": (context) => ProfileRoute(),
          "/profile/edit": (context) => ProfileEditRoute()
        }
      )
    );
  }
}

class LoginInfo extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get loginStatus => _isLoggedIn;
  void loggedIn() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void loggedOut() {
    _isLoggedIn = false;
    notifyListeners();
  }

  List<String> _appBarTitles = ["Home", "Search", "Notifications"];
  int titleIndex = 0;
  String getAppBarTitle() => _appBarTitles[titleIndex];
  void toggleTitleIndex(int index) {
    titleIndex = index;
    notifyListeners();
  }

  List<Color> _navBarIconColors = [Color(0xff000070), Colors.white, Colors.white];
  List<Color> get navBarIconColors => _navBarIconColors;
  void toggleIconColor(int index) {
    switch(index) {
      case 0: {
        _navBarIconColors = [Color(0xff000070), Colors.white, Colors.white];
      }
      break;
      case 1: {
        _navBarIconColors = [Colors.white, Color(0xff000070), Colors.white];
      }
      break;
      case 2: {
        _navBarIconColors = [Colors.white, Colors.white, Color(0xff000070)];
      }
      break;
    }
    notifyListeners();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignIn get googleSignIn => _googleSignIn;

  Map<String, String> _userData = {
    "email": "",
    "display_name": "",
    "info": "",
    "status": "",
    "unique_id": "",
  };

  void setUserData(String email, String displayName, String info, String status, String uid,) {
    _userData["email"] = email;
    _userData["display_name"] = displayName;
    _userData["info"] = info;
    _userData["unique_id"] = uid;
    _userData["status"] = status;
  }

  void dropUserData() {
    _userData["email"] = "";
    _userData["display_name"] = "";
    _userData["info"] = "";
    _userData["status"] = "";
    _userData["unique_id"] = "";
  }

  Map<String, String> get userData => _userData;

  Future<GoogleSignInAccount> signInGoogle() async {
    return await _googleSignIn.signIn();
  }

  void signOutGoogle() async {
    await _googleSignIn.signOut();
    dropUserData();
  }
}

void main() => runApp(MyApp());