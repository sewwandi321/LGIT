import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:learn_git/constants/const.dart';
import 'package:learn_git/services/storage_services.dart';

/**
 * created by IT19129518 Rathnayake R.M.D.M
 */
class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot? _lastDocument;
  List noteList = [];
//learn from tutorial
//This method is used to add documents to the  blog collection
  Future<String> addNote(String title, String content) async {
    String res = "Success";
    String id = generateId();
    try {
      /**
       * This questionPicUrl will get image url which is uploaded to the
       * firbase storage and then it will pass to json object.Then image url and all the relevent
       * information will send as a json object to firebase firestore
       * Then it will save in question collection as a new document
       * 
      //  */
      // String QuestionPicUrl =
      //     await StorageServices().uploadImgToStorage('question', file);
      Map<String, dynamic> notes = {
        "id": id,
        "title": title,
        "content": content,
        //"blogPicUrl": QuestionPicUrl
      };

      await _firestore.collection("notes").doc(id).set(notes);
    } catch (e) {
      return e.toString();
    }

    return res;
  }

  Future getNotes() async {
    try {
      await _firestore.collection("notes").get().then((quertSnapshot) {
        for (var result in quertSnapshot.docs) {
          noteList.add(result.data());
          debugPrint("noteList - $noteList");
        }
      });

      return noteList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}
