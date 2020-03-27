import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noname/main.dart';

class ProfileRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<LoginInfo>(
      builder: (BuildContext context, LoginInfo loginInfo, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Profile", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 25.0)),
            titleSpacing: 20.0,
            backgroundColor: Color(0xff000070)
          ),
          body: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text(loginInfo.userData["display_name"], style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 25.0, color: Color(0xff000070)))
                  ],
                  mainAxisAlignment: MainAxisAlignment.center
                ),
                padding: const EdgeInsets.symmetric(vertical: 6.0)
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text(loginInfo.userData["unique_id"], style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 16.0, color: Color(0xff000070)))
                  ],
                  mainAxisAlignment: MainAxisAlignment.center
                )
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text("Status: ${loginInfo.userData["status"]}", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Colors.black))
                  ]
                ),
                padding: const EdgeInsets.only(left: 6.0, top: 8.0)
              ),
              Container(
                child: Text(
                  loginInfo.userData["info"] == "" ? "Info: Start filling out your info. It feels so lonely here." : "Info: ${loginInfo.userData["info"]}",
                style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 19.0, color: Colors.black)),
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0)
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text("Your Posts", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 24.0, color: Color(0xff000070)))
                  ],
                ),
                margin: const EdgeInsets.only(left: 6.0, top: 10.0)
              ),
            ]
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit, color: Color(0xff000070), size: 30.0),
            onPressed: () {},
            backgroundColor: Colors.white,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        );
      }
    );
  }
}