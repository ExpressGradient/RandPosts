import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noname/main.dart';
import 'login_route.dart';

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginInfo>(
      builder: (BuildContext context, LoginInfo loginInfo, Widget child) {
        return loginInfo.loginStatus ? HomeRouteDisplay() : LoginRoute();
      }
    );
  }
}

class HomeRouteDisplay extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginInfo>(
      builder: (BuildContext context, LoginInfo loginInfo, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Home", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 25.0)),
            titleSpacing: 20.0,
            backgroundColor: Color(0xff000070),
          ),
          drawer: Drawer(
            child: Container(
              color: Color(0xff000070),
              child: Column(
                children: <Widget>[
                  FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person, color: Colors.white, size: 25.0),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0)),
                        Text(loginInfo.userData["display_name"], style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Colors.white))
                      ]
                    ),
                    onPressed: () => Navigator.pushNamed(context, "/profile")
                  )
                ]
              ),
              padding: const EdgeInsets.only(left: 10.0, top: 20.0)
            )
          ),
          body: Center(
            child: RaisedButton(
              child: Text("Sign Out", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 22.0, color: Colors.white)),
              padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
              color: Color(0xff000070),
              elevation: 2.5,
              onPressed: () {
                loginInfo.signOutGoogle();
                loginInfo.changeLoginStatus();
              }
            )
          )
        );
      },
    );
  }
}