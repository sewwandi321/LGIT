import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:learn_git/constants/const.dart';
import 'package:learn_git/services/storage_services.dart';

/**
 * created by IT19159072 A.N.S.Thenuwara
 */
class QuestionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot? _lastDocument;
  List questionList = [];
//learn from tutorial
//This method is used to add documents to the  blog collection
  Future<String> addQuestion(
      String question, String content, Uint8List file) async {
    String res = "Success";
    String id = generateId();
    try {
      /**
       * This questionPicUrl will get image url which is uploaded to the
       * firbase storage and then it will pass to json object.Then image url and all the relevent
       * information will send as a json object to firebase firestore
       * Then it will save in question collection as a new document
       * 
       */
      String QuestionPicUrl =
          await StorageServices().uploadImgToStorage('question', file);
      Map<String, dynamic> questions = {
        "id": id,
        "question": question,
        "content": content,
        "blogPicUrl": QuestionPicUrl
      };

      await _firestore.collection("questions").doc(id).set(questions);
    } catch (e) {
      return e.toString();
    }

    return res;
  }

/**
 * Fetch all the questions from questions collection
 */
  Future getQuestions() async {
    try {
      await _firestore.collection("questions").get().then((quertSnapshot) {
        for (var result in quertSnapshot.docs) {
          questionList.add(result.data());
          debugPrint("questionList - $questionList");
        }
      });

      return questionList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}
