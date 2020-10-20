import 'package:flutter/material.dart';
import 'package:quizbox/main.dart';
import 'package:quizbox/services/auth.dart';
import 'package:quizbox/views/show_details.dart';
import 'package:quizbox/views/update_info.dart';

class StudentProfile extends StatefulWidget {

  String uid;
  StudentProfile({this.uid});

  @override
  _StudentProfileState createState() => _StudentProfileState(uid: uid);
}

class _StudentProfileState extends State<StudentProfile> {

  String uid;
  _StudentProfileState({this.uid});

  void _updateInfo(context, uid){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return SingleChildScrollView(
            child: Container(
              height: 1000,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: UpdateInfo(uid: uid),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",style: TextStyle(fontWeight: FontWeight.bold),),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async{
              googleSignOut().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (_){
                    return MyApp();
                  }
              )));
            },
            icon: Icon(Icons.power_settings_new),
            label: Text('SignOut'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //ImagesInput(),
            SizedBox(height: 15.0,),
            ShowDetails(uid: uid,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.mode_edit),
        onPressed: () => _updateInfo(context,uid),
      ),
    );
  }
}
