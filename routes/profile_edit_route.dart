import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noname/main.dart';

class ProfileEditRoute extends StatefulWidget {
  @override
  _ProfileEditRouteState createState() => _ProfileEditRouteState();
}

class _ProfileEditRouteState extends State<ProfileEditRoute> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final statusController = TextEditingController();
  final infoController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    statusController.dispose();
    infoController.dispose();
  }

  bool _checkInputs() {
    if(usernameController.text.length <= 20 && statusController.text.length <= 30 && infoController.text.length >= 30 && infoController.text.length <= 150) {
      return true;
    }
    return false;
  }

  void _clearInputs() {
    if(_checkInputs()) {
      setState(() {
        usernameController.text = "";
        statusController.text = "";
        infoController.text = "";
      });
    }
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
            child: Column(
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
                    textAlign: TextAlign.center,
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
                RaisedButton(
                  child: Text("Save", style: TextStyle(fontFamily: "IBMPlexSans", color: Colors.white, fontSize: 25.0)),
                  onPressed: () {},
                  color: Color(0xff000070),
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0)
                )
              ]
            )
          ) 
        );
      }
    );
  }
}