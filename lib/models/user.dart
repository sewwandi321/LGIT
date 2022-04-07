import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * created by IT19123196(K.H.T.N Dewangi)
 */
class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  //final String university;
  final List followers;
  final List following;

  const User(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.bio,
      required this.followers,
      required this.following});

// ignore: slash_for_doc_comments
/**From Tutorial
 * we create 2 json methods.this methos use to convert
 * user object file
 */
  Map<String, dynamic> toConvertJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
  // ignore: slash_for_doc_comments
  /**From Tutorial
       * convert snap to user model
       * return to auth service
       * we can use it anywhere we want use only thing we want to do just 
       * calling method then we don't want to pass snapshop every where*/
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }
}
