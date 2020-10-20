import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizbox/models/user.dart';
import 'package:quizbox/models/user_data.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  // user collection
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String name,String phoneNo,String photoUrl,String regNo,String branch,String gender) async{
    //print("user id: ${uid}");
    return await userCollection.document(uid).setData({
      'name': name,
      'phoneNo' : phoneNo,
      'photoUrl': photoUrl,
      'regNo': regNo,
      'branch': branch,
      'gender': gender,
    });
  }

  // student list from snapshot
  List<User_Data> _userDataDetailFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return User_Data(
        name: doc.data['name'] ?? '0',
        phoneNo: doc.data['phoneNo']??'0',
        photoUrl: doc.data['photoUrl']??'0',
        regNo: doc.data['regNo']??'0',
        branch: doc.data['branch']??'0',
        gender: doc.data['gender']??'0',
      );
    }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return  UserData(
      uid:uid,
      name: snapshot.data['name'],
      phoneNo: snapshot.data['phoneNo'],
      photoUrl: snapshot.data['photoUrl'],
      regNo: snapshot.data['regNo'],
      branch: snapshot.data['branch'],
      gender: snapshot.data['gender'],
    );
  }

  Stream<List<User_Data>> get user_Data {
    return userCollection.snapshots().map(_userDataDetailFromSnapshot);
  }

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}