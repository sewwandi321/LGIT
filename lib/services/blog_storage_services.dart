import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../constants/const.dart';

/*Created by - IT19246024 - Warnakulasuriya D.A*/
class BlogStorageServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImgToStorage(String childName, Uint8List file) async {
    // Learn from tutorial - Create location in firebase storage
    /**ref method point to storage and can reference file that already exists or 
     * if there are not any existing files then new folder will create and the image will be save there. 
     * if the folder exists then the image will be save in that particular folder.
     * 
      */
    // Reference ref =
    //     _storage.ref().child(childName).child(_auth.currentUser!.uid);

    String img = generateId();
    Reference storageReference =
        _storage.ref().child(childName).child("$img.jpg");

    UploadTask uploadTask = storageReference.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    //this will return the downloadUrl of the image which is saved in the firebase storage.
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
