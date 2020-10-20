import 'package:flutter/material.dart';
import 'package:quizbox/models/user.dart';
import 'package:quizbox/services/database.dart';

class UpdateInfo extends StatefulWidget {

  String uid;
  UpdateInfo({this.uid});

  @override
  _UpdateInfoState createState() => _UpdateInfoState(uid: uid);
}

class _UpdateInfoState extends State<UpdateInfo> {

  String uid;
  _UpdateInfoState({this.uid});

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentPhone;
  String _currentPhoto;
  String _currentReg;
  String _currentGender;
  String _currentBranch;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: uid).userData,
      builder: (context,snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Update your Info....",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 25.0,),
                SizedBox(height: 15.0,),
                TextFormField(
                  initialValue: userData.name,
                  decoration: InputDecoration(hasFloatingPlaceholder: true, hintText: "Enter Your Username"),
                  validator: (input){
                    if(input.isEmpty){
                      return "Enter Name";
                    }
                  },
                  onChanged: (val){
                    setState(() {
                      _currentName = val;
                    });
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  initialValue: userData.phoneNo,
                  decoration: InputDecoration(hasFloatingPlaceholder: true, hintText: "Enter phone number"),
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Enter Phone Nuumber";
                    }
                  },
                  onChanged: (val) {
                    setState(() => _currentPhone = val);
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  initialValue: userData.branch,
                  decoration: InputDecoration(hasFloatingPlaceholder: true, hintText: "Enter Your Branch"),
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Enter Branch";
                    }
                  },
                  onChanged: (val) {
                    setState(() => _currentBranch = val);
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  initialValue: userData.regNo,
                  decoration: InputDecoration(hasFloatingPlaceholder: true, hintText: "Enter your registration number"),
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Enter Registration Number";
                    }
                  },
                  onChanged: (val) {
                    setState(() => _currentReg = val);
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  initialValue: userData.gender,
                  decoration: InputDecoration(hasFloatingPlaceholder: true, hintText: "Enter your gender"),
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Enter gender";
                    }
                  },
                  onChanged: (val) {
                    setState(() => _currentGender = val);
                  },
                ),
                SizedBox(height: 15,),
                FlatButton(
                  child: Text("Update"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: uid).updateUserData(
                        _currentName ?? userData.name,
                        _currentPhone ?? userData.phoneNo,
                        _currentPhoto ?? userData.photoUrl,
                        _currentReg ?? userData.gender,
                        _currentBranch ?? userData.branch,
                        _currentGender ?? userData.gender,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        }
        else{
          return Container(
            child: Text("You got an error"),
          );
        }
      },
    );
  }
}
