import 'package:flutter/material.dart';
import 'package:quizbox/services/auth.dart';

class RegisterTopics extends StatefulWidget {

  String uid;
  RegisterTopics({this.uid});

  @override
  _RegisterTopicsState createState() => _RegisterTopicsState();
}

class _RegisterTopicsState extends State<RegisterTopics> {

  List<String> topic = new List();
  String id ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select topics of your interests"),
        actions: <Widget>[
          IconButton(
            icon: CircleAvatar(
              radius: 18.0,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
        ],
      ),
    );
  }
}
