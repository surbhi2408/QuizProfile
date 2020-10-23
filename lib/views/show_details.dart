// surbhi mayank

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizbox/models/user.dart';
import 'package:quizbox/services/auth.dart';
import 'package:quizbox/services/database.dart';

class ShowDetails extends StatefulWidget {

  String uid;
  String fileName;
  ShowDetails({this.uid});

  @override
  _ShowDetailsState createState() => _ShowDetailsState(uid: uid,fileName: fileName);
}

class _ShowDetailsState extends State<ShowDetails> {

  String uid;
  String fileName;
  _ShowDetailsState({this.uid,this.fileName});

  File _imageFile;

  // using this function image is picked from the specified source file
  Future _getImage(BuildContext context,ImageSource source) async{
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image){
      setState(() {
        _imageFile = image;
      });
      Navigator.pop(context);
    });
  }

  // uploading pic to fireStore and fetching the same pic to app
  Future uploadPic(BuildContext context) async {
    fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((newImageDownloadUrl){
      imageUrl = newImageDownloadUrl;
      Firestore.instance.collection('users').document(id).updateData({
        'photoUrl': imageUrl,
      });
    });

    // when pic is uploaded successfully to fireStore a message is displayed
    setState(() {
      print("Profile Picture Uploaded");
      print(_imageFile);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded'),));
    });
  }

  // user can choose camera as well as gallery to upload their profile picture
  void _openImagePicker(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Pick an Image",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0,),
                FlatButton(
                  child: Text(
                    "Use Camera",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: (){
                    _getImage(context, ImageSource.camera);
                  },
                ),
                SizedBox(height: 5.0,),
                FlatButton(
                  onPressed: (){
                    _getImage(context, ImageSource.gallery);
                  },
                  child: Text(
                    "From Gallery",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // data is uploaded using snapshots
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: uid).userData,
      builder: (context, snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // photo
                Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.blueAccent,
                    child: ClipOval(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: (_imageFile == null)
                            ? Image.network(
                          userData.photoUrl,
                          fit: BoxFit.fill,
                        )
                            : Image.file(_imageFile, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),

                // icon button to pick image from camera or gallery
                Align(
                  alignment: Alignment.topCenter,
                  child: FlatButton.icon(
                    onPressed: (){
                      _openImagePicker(context);
                    },
                    icon: Icon(Icons.add_a_photo),
                    label: Text(""),
                  ),
                ),

                // after clicking to add photo in app image gets uploaded to fireStore
                Align(
                  alignment: Alignment.topCenter,
                  child: FlatButton(
                    child: Text("ADD PHOTO"),
                    onPressed: (){
                      uploadPic(context);
                    },
                  ),
                ),

                // username
                SizedBox(height: 20.0,),
                Text(
                  "Your UserName",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                    color: Colors.black26,
                  ),
                ),
                SizedBox(height: 12.0,),
                Text(
                    "${userData.name}",
                  style: TextStyle(fontSize: 20),
                ),

                // phone number
                SizedBox(height: 20,),
                Text(
                  "Your Phone Number",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                    color: Colors.black26,
                  ),
                ),
                SizedBox(height: 12.0,),
                Text(
                    "${userData.phoneNo}",
                  style: TextStyle(fontSize: 20),
                ),

                // registration number
                SizedBox(height: 20,),
                Text(
                  "Your Registration Number",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                    color: Colors.black26,
                  ),
                ),
                SizedBox(height: 12.0,),
                Text(
                    "${userData.regNo}",
                  style: TextStyle(fontSize: 20),
                ),

                // user's branch
                SizedBox(height: 20,),
                Text(
                  "Your Branch",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                    color: Colors.black26,
                  ),
                ),
                SizedBox(height: 12.0,),
                Text(
                    "${userData.branch}",
                  style: TextStyle(fontSize: 20),
                ),

                // user's gender
                SizedBox(height: 20,),
                Text(
                  "Your Gender",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                    color: Colors.black26,
                  ),
                ),
                SizedBox(height: 12.0,),
                Text(
                    "${userData.gender}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20,),
              ],
            ),
          );
        }

        // if snapshot doesn't contain any data initially error message is displayed
        else{
          return Container(child: Text("You got an error"),);
        }
      },
    );
  }
}
