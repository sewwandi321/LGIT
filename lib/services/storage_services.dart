import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

/**
 * created by IT19123196(K.H.T.N Dewangi)
 */
class StorageServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  /**Reference From Tutorial 
   * in storage adding image to firebase storage 
   * 1st we want to change rules */

  Future<String> uploadImgToStorage(String childName, Uint8List file) async {
    // Create location in firebase storage
    /**This ref method point to storage this can reference file that already exisit or
     * not exist (we don't have any file).then create child
     * this child can be a folder(that folder can exiist and can not exsist)
     * if exists it goes to that folder if not it create new folder
     * Since this Future we can use async
      */
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    //return downloadurl for store it in firestore database(to the Auth Services)
    return downloadUrl;
  }
}
