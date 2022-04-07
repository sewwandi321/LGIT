import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: library_prefixes
import 'package:learn_git/models/user.dart' as modelClass;
import 'package:learn_git/services/storage_services.dart';

/**
 * created by IT19123196(K.H.T.N Dewangi)
 */
class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Signing Up User
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Error";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // Register user using email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        /**From Tutorial 
         * Sent photo to storage service and store it in storage and
         * Get PhotoURL from Storage service to store db
         * pass 2 parameters (folder name and file) */
        String photoUrl =
            await StorageServices().uploadImgToStorage('profilePics', file);

        modelClass.User _user = modelClass.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        // adding user in our database
        // await _firestore.collection("users").doc(cred.user!.uid).set({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'photoUrl': photoUrl,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });
        print('dewwwwww');
        print(cred.user!.uid);
        // await _firestore.collection("users").doc(cred.user!.uid).set({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        //   'photoUrl': photoUrl,
        // });
        // adding user in our database

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toConvertJson());

        res = "success";
      } else {
        res = "Please Check And Enter All Fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Error";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // login user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please Check And Enter All Fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // get user details
  Future<modelClass.User> getUserDetails() async {
    User cUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(cUser.uid).get();

    return modelClass.User.fromSnap(snap);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
  // Future deleteUser(String email, String password) async {
  //   try {
  //      User cUser = _auth.currentUser!;

  //     // AuthCredential credentials =
  //     //     EmailAuthProvider.getCredential(email: email, password: password);
  //     print(cUser);
  //     //AuthResult result = await cUser.reauthenticateWithCredential(credentials);
  //     await DatabaseService(uid: result.user.uid).deleteuser(); // called from database class
  //     await result.user.delete();
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
}
