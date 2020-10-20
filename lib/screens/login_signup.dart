import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizbox/animations/fade_animation.dart';
import 'package:quizbox/services/auth.dart';
import 'package:quizbox/widgets/home_widget.dart';

class LoginSignup extends StatefulWidget {

  String uid;
  LoginSignup({this.uid});

  @override
  _LoginSignupState createState() => _LoginSignupState(uid: uid);
}

class _LoginSignupState extends State<LoginSignup> {

  String uid;
  _LoginSignupState({this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: 300,
            width: 300,
            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: FadeAnimation(1.2,Text(
              'QuizBox',
              style: TextStyle(
                letterSpacing: 7,
                fontFamily: 'Montserrat',
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: Colors.indigo,
              ),
            ),
            ),
          ),
          SizedBox(
              height: 120,
              width: 500,
              child: Divider(
                color: Colors.black,
              )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 280, 0, 0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeAnimation(1.2,Text("I'm using QuizBox...",
                  style: GoogleFonts.montserrat(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: 2,
                  ),),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 330, 20, 0),
            child: GestureDetector(
              // onTap: (){
              //   signInWithGoogle().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
              //     return Container();//TODO add teachers home
              //   }))); //TODO add auth func
              //},
                child: FadeAnimation(1.3,Container(
                  margin: EdgeInsets.symmetric(),
                  height: 70,
                  child: Card(
                    color: Colors.indigo,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: ListTile(
                        title: Text(
                          '   As a Teacher',
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        leading:Container(
                          child: ClipRect(
                              child: Image(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/teacher.png'),
                              )
                          ),
                        )
                    ),
                  ),
                ),)
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 410, 20, 0),
            child: GestureDetector(
              onTap: (){
                signInWithGoogle().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (_){
                      return Home(uid: id,);
                    }))); //todo add auth
              },
                child: FadeAnimation(1.3,Container(
                  height: 70,
                  child: Card(
                    color: Colors.orangeAccent,
                    shadowColor: Colors.black,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: ListTile(
                        title: Text(
                          '       As Student',
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        leading:Container(
                          height: 50,
                          width: 50,
                          child: ClipRect(
                            child: Image.asset('assets/images/student.png',fit: BoxFit.fill,),
                          ),
                        )
                    ),
                  ),
                ),)
            ),
          ),
        ],
      ),
    );
  }

}
