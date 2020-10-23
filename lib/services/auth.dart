// surbhi mayank

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizbox/services/database.dart';

final GoogleSignIn googleSignIn = new GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

String name = '';
String phoneNo = '';
String imageUrl = '';
String id = '';

// google sign in
Future<String> signInWithGoogle() async {
  GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    AuthResult result = await _auth.signInWithCredential(credential);

    final FirebaseUser user = await _auth.currentUser();

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = result.user;
      assert(user.uid == currentUser.uid);
      assert(user.email != null);
      assert(user.uid != null);
      assert(user.displayName != null);
      assert(user.photoUrl != null);
    }

    id = user.uid;
    name = user.displayName;
    phoneNo = user.phoneNumber;
    imageUrl = user.photoUrl;

    await DatabaseService(uid: user.uid).updateUserData(name, phoneNo, imageUrl, null, null, null);

    //HelperFunctions.saveUserLoggedInDetails(isLoggedIn: true);

    print("Username: ${user.uid}");
    return '${user}';
    //return Future.value(true);
  }
}

// sign out
Future<void> googleSignOut() async{
  await googleSignIn.signOut();
  print("user signed out");
}