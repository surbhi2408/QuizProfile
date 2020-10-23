// surbhi mayank

import 'package:flutter/material.dart';
import 'package:quizbox/main.dart';
import 'package:quizbox/services/auth.dart';
import 'package:quizbox/views/register_topics.dart';
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

  // updating info where details are given in bottom sheet after clicking edit floating button
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
        // signOut button
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
            SizedBox(height: 24.0,),

            // registering for quizzes
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_){
                  return RegisterTopics(uid: id,);
                }));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 48,
                child: Text(
                    "Register for Quizzes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // edit button for updating info
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.mode_edit),
        onPressed: () => _updateInfo(context,uid),
      ),
    );
  }
}
