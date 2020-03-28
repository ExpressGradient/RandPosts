import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noname/main.dart';
import 'login_route.dart';
import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';

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
                  ),
                  FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person_outline, color: Colors.white, size: 25.0),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0)),
                        Text("Sign Out", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Colors.white))
                      ]
                    ),
                    onPressed: () {
                      loginInfo.signOutGoogle();
                      loginInfo.changeLoginStatus();
                    }
                  )
                ]
              ),
              padding: const EdgeInsets.only(left: 10.0, top: 20.0)
            )
          ), 
          bottomNavigationBar: BubbledNavigationBar(
            defaultBubbleColor: Colors.white,
            onTap: (index) {
              print("Current Index $index");
            },
            items: <BubbledNavigationBarItem>[
              BubbledNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white, size: 30.0),
                activeIcon: Icon(Icons.home, color: Color(0xff000070), size: 30.0),
                title: Text("Home", style: TextStyle(fontFamily: "IBMPlexSans", color: Color(0xff000070), fontSize: 20.0))
              ),
              BubbledNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.white, size: 30.0),
                activeIcon: Icon(Icons.search, color: Color(0xff000070), size: 30.0),
                title: Text("Search", style: TextStyle(fontFamily: "IBMPlexSans", color: Color(0xff000070), fontSize: 20.0))
              ),
            ],
            backgroundColor: Color(0xff000070),
          )
        );
      },
    );
  }
}