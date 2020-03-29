import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noname/main.dart';

class PostContent extends StatefulWidget {
  @override
  _PostContentState createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final tagController = TextEditingController();
  final contentController = TextEditingController();
  final CollectionReference _postsCollection = Firestore.instance.collection("posts");

  Future<void> uploadPost(BuildContext context, LoginInfo loginInfo) async {
    final String title = titleController.text;
    final List<String> tags = tagController.text.split(", ");
    final String content = contentController.text;

    int rand_id = await _postsCollection.getDocuments().then((result) => result.documents.length) + 1;

    await _postsCollection.document(rand_id.toString()).setData({
      "title": title,
      "tags": tags,
      "by": loginInfo.userData["display_name"],
      "content": content,
    });

    print("Post Uploaded to Firestore");

    _clearInputs();

    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    tagController.dispose();
    contentController.dispose();
  }

  void _clearInputs() {
    setState(() {
      titleController.text = "";
      tagController.text = "";
      contentController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginInfo>(
      builder: (BuildContext context, LoginInfo loginInfo, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Write a new Post", style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 25.0)),
            backgroundColor: Color(0xff000070),
            titleSpacing: 20.0,
            automaticallyImplyLeading: false
          ),
          body: Form(
            key: _formKey,
            child: ListView(
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
                      labelText: "Title:",
                      labelStyle: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Color(0xff000070))
                    ),
                    style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 22.0, color: Color(0xff000070)),
                    controller: titleController,
                    maxLength: 60,
                    cursorColor: Color(0xff000070),
                    validator: (inputText) {
                      if(inputText.isEmpty) {
                        return "Please enter a title";
                      } else {
                        return null;
                      }
                    },
                  ),
                  margin: const EdgeInsets.all(10.0)
                ),
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
                      labelText: "Tags:",
                      helperText: "Comma-Space Seperated Values",
                      hintText: "Deep Learning, Deep Reinforcement Learning",
                      hintStyle: TextStyle(fontFamily: "IBMPlexSans", fontSize: 18.0),
                      labelStyle: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Color(0xff000070)),
                      helperStyle: TextStyle(fontFamily: "IBMPlexSans", color: Color(0xff000070))
                    ),
                    style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 22.0, color: Color(0xff000070)),
                    controller: tagController,
                    maxLength: 60,
                    cursorColor: Color(0xff000070),
                    validator: (inputText) {
                      if(inputText.isEmpty) {
                        return "Please enter a title";
                      } else {
                        return null;
                      }
                    },
                  ),
                  margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0)
                ),
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
                      labelStyle: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Color(0xff000070)),
                      labelText: "Post Content:"
                    ),
                    style: TextStyle(fontFamily: "IBMPlexSans", fontSize: 20.0, color: Color(0xff000070)),
                    controller: contentController,
                    maxLines: 11,
                    maxLength: 1000,
                    cursorColor: Color(0xff000070),
                    validator: (inputText) {
                      if(inputText.isEmpty) {
                        return "Please enter a post's content";
                      } else {
                        return null;
                      }
                    }
                  ),
                  margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0)
                ),
                Row(
                  children: <Widget>[
                    OutlineButton(
                      child: Text("Cancel", style: TextStyle(fontFamily: "IBMPlexSans", color: Color(0xff000070), fontSize: 22.0)),
                      onPressed: () {
                        _clearInputs();
                        Navigator.pop(context);
                      },
                      borderSide: BorderSide(
                        color: Color(0xff000070),
                        width: 1.5
                      ),
                    ),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 15.0)),
                    RaisedButton(
                      child: Text("Upload", style: TextStyle(fontFamily: "IBMPlexSans", color: Colors.white, fontSize: 22.0)),
                      onPressed: () => uploadPost(context, loginInfo),
                      color: Color(0xff000070),
                      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 13.0),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center
                )
              ]
            )
          )
        );
      }
    );
  }
}