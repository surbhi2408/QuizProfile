import 'package:flutter/material.dart';
import 'package:quizbox/main.dart';
import 'package:quizbox/services/auth.dart';
import 'package:quizbox/views/home_page.dart';
import 'package:quizbox/views/leader_board.dart';
import 'package:quizbox/views/student_profile.dart';

class Home extends StatefulWidget {

  String uid;
  Home({this.uid});

  @override
  _HomeState createState() => _HomeState(uid: uid);
}

class _HomeState extends State<Home> {

  String uid;
  _HomeState({this.uid});

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    LeaderBoard(),
    StudentProfile(uid: id,),
  ];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text("LeaderBoard"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("Profile"),
          ),
        ],
      ),
    );
  }
}
