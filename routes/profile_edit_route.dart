import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noname/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileEditRoute extends StatefulWidget {
  @override
  _ProfileEditRouteState createState() => _ProfileEditRouteState();
}

class _ProfileEditRouteState extends State<ProfileEditRoute> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final statusController = TextEditingController();
  final infoController = TextEditingController();
  final CollectionReference _userCollection = Firestore.instance.collection("users");

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    statusController.dispose();
    infoController.dispose();
  }

  void _clearInputs() {
    setState(() {
      usernameController.text = "";
      statusController.text = "";
      infoController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginInfo>(
      builder: (BuildContext context, LoginInfo loginInfo, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit Profile", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 25.0)),
            titleSpacing: 20.0,
            backgroundColor: Color(0xff000070)
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff000070),
                              width: 1.5
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff000070),
                              width: 1.5
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff000070),
                              width: 1.5
                            ),
                          ),
                          labelText: "Enter a new Username",
                          labelStyle: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Color(0xff000070))
                        ),
                        maxLength: 20,
                        style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Color(0xff000070)),
                        controller: usernameController,
                        cursorColor: Color(0xff000070),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0)
                    ),
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Color(0xff000070)
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Color(0xff000070)
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Color(0xff000070)
                            )
                          ),
                          labelText: "Enter a new Status",
                          labelStyle: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Color(0xff000070))
                        ),
                        style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Color(0xff000070)),
                        maxLength: 40,
                        controller: statusController,
                        cursorColor: Color(0xff000070),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 15.0)
                    ),
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Color(0xff000070)
                            )
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Color(0xff000070)
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Color(0xff000070)
                            )
                          ),
                          labelText: "Enter a new Info",
                          labelStyle: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Color(0xff000070))
                        ),
                        style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Color(0xff000070)),
                        maxLength: 150,
                        maxLines: 4,
                        cursorColor: Color(0xff000070),
                        controller: infoController
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0)
                    ),
                    Row(
                      children: <Widget>[
                        OutlineButton(
                          child: Text("Cancel", style: TextStyle(fontFamily: "IBMPlexSans", color: Color(0xff000070), fontSize: 22.0)),
                          borderSide: BorderSide(
                            color: Color(0xff000070)
                          ),
                          onPressed: () {
                            _clearInputs();
                            Navigator.pop(context);
                          }
                        ),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 15.0)),
                        RaisedButton(
                          child: Text("Save", style: TextStyle(fontFamily: "IBMPlexSans", color: Colors.white, fontSize: 22.0)),
                          color: Color(0xff000070),
                          onPressed: () async {
                            print(loginInfo.userData["unique_id"]);
                            await _userCollection.document(loginInfo.userData["unique_id"]).updateData({
                              "display_name": usernameController.text != "" ? usernameController.text : loginInfo.userData["display_name"],
                              "status": statusController.text != "" ? statusController.text : loginInfo.userData["status"],
                              "info": infoController.text != "" ? infoController.text : loginInfo.userData["info"] 
                            });
                            loginInfo.setUserData(
                              loginInfo.userData["email"],
                              usernameController.text != "" ? usernameController.text : loginInfo.userData["display_name"],
                              infoController.text != "" ? infoController.text : loginInfo.userData["info"],
                              statusController.text != "" ? statusController.text : loginInfo.userData["status"],
                              loginInfo.userData["unique_id"]
                            );
                            _clearInputs();
                            Navigator.pop(context);
                          }
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center
                    )
                  ]
                ),
              ]
            )
          ),
        );
      }
    );
  }
}