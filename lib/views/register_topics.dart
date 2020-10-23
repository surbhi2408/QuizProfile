// surbhi mayank

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:quizbox/services/auth.dart';
import 'package:quizbox/services/database.dart';
import 'package:quizbox/widgets/home_widget.dart';

class RegisterTopics extends StatefulWidget {

  String uid;
  RegisterTopics({this.uid});

  @override
  _RegisterTopicsState createState() => _RegisterTopicsState();
}

class _RegisterTopicsState extends State<RegisterTopics> {

  List<String> topic = new List();
  String id ='';

  DatabaseService databaseService = new DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Topics"),
        actions: <Widget>[
          IconButton(
            icon: CircleAvatar(
              radius: 18.0,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Text(
            "Select topics of your interests",
            style: TextStyle(
              fontSize: 20.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18.0),
          ),

          // multiple topics can be selected to appear quiz
          CheckboxGroup(
            orientation: GroupedButtonsOrientation.VERTICAL,
            margin: const EdgeInsets.only(left: 12.0),
            labels: <String>[
              "Operating System",
              "DBMS",
              "JAVA",
              "Python",
              "AutoMobile",
              "Sports",
              "Business",
              "Data Structure",
              "Global",
              "Science",
              "Maths",
              "Mechanics",
            ],
            onSelected: (List<String> checked){
              topic = checked;
            },
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Click clear if you want to clear the list or click submit to save your interests",
              style: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

          // button for clear
          GestureDetector(
            onTap: (){
              topic.clear();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 18,horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - 48,
              child: Text(
                "CLEAR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          SizedBox(height: 24.0,),
          // button to submit
          GestureDetector(
            onTap: (){
              handleSubmit(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 18,horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - 48,
              child: Text(
                "SUBMIT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  handleSubmit(BuildContext context) async{
    // error message is displayed if nothing is selected
    if(topic.length == 0){
      Flushbar(
        padding: EdgeInsets.all(10.0),
        borderRadius: 8,
        backgroundGradient: LinearGradient(
          colors: [Colors.red.shade500, Colors.orange.shade500],
          stops: [0.5, 1],
        ),
        boxShadows: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(3,3),
            blurRadius: 3,
          ),
        ],
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        title: "Something is missing!!!",
        message: "You have not selected anything atleast choose one option",
        duration: Duration(seconds: 3),
      )..show(context);
    }

    // id = id;
    // Map<String,dynamic> quizMap = {
    //   'topics' : topic,
    // };

    //await databaseService.addUserTopics(quizMap, id);

    // Navigator.pushReplacement(context, MaterialPageRoute(
    //   builder: (context) => Home(),
    // ));
  }
}
