import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:learn_git/constants/const.dart';
import 'package:uuid/uuid.dart';

class AnswerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot? _lastDocument;
  List answerList = [];

  // Future<String> addAnswers(String answer, String text) async {
  //   String res = "Success";
  //   String id = generateId();
  //   try {
  //     Map<String, dynamic> answers = {
  //       "id": id,
  //       "answer": answer,
  //     };

  //     await _firestore.collection("answers").doc(id).set(answers);
  //   } catch (e) {
  //     return e.toString();
  //   }

  //   return res;
  // }

  Future getAnswers() async {
    try {
      await _firestore.collection("answers").get().then((quertSnapshot) {
        for (var result in quertSnapshot.docs) {
          answerList.add(result.data());
          debugPrint("answerLIst - $answerList");
        }
      });

      return answerList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  // Post comment
  Future<String> postComment(String postId, String text) async {
    print("answerController.text1111)");
    print(text);
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        print("answerController.text111qqq1)");
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('questions')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'text': text,
          'commentId': commentId,
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      print("hhhhhhhhhhhhhhhhh");
      print(err);
      res = err.toString();
    }
    return res;
  }
}
