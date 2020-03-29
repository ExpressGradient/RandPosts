import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noname/main.dart';
import 'login_route.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
            title: Text(loginInfo.getAppBarTitle(), style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 25.0)),
            titleSpacing: 20.0,
            backgroundColor: Color(0xff000070),
            actions: <Widget>[
              FlatButton(
                child: Text("Sign Out", style: TextStyle(fontFamily: "IBMPlexSans", color: Colors.white)),
                color: Color(0xff000070),
                onPressed: () {
                  loginInfo.dropUserData();
                  loginInfo.signOutGoogle();
                  loginInfo.loggedOut();
                }
              )
            ],
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
                  ),
                ]
              ),
              padding: const EdgeInsets.only(left: 10.0, top: 20.0)
            ),
          ), 
          bottomNavigationBar: CurvedNavigationBar(
            color: Color(0xff000070),
            backgroundColor: Colors.white,
            buttonBackgroundColor: Colors.white,
            height: 50.0,
            items: <Widget>[
              Icon(Icons.home, color: loginInfo.navBarIconColors[0], size: 30.0),
              Icon(Icons.search, color: loginInfo.navBarIconColors[1], size: 30.0),
              Icon(Icons.notifications, color: loginInfo.navBarIconColors[2], size: 30.0)
            ],
            onTap: (index) {
              loginInfo.toggleTitleIndex(index);
              loginInfo.toggleIconColor(index);
            } 
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white, size: 25.0),
            backgroundColor: Color(0xff000070),
            onPressed: () => Navigator.pushNamed(context, "/post")
          )
        );
      },
    );
  }
}