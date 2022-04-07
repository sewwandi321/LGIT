import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../constants/const.dart';
import 'blog_storage_services.dart';

/*Created by - IT19246024 - Warnakulasuriya D.A*/
class BlogService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot? _lastDocument;
  List blogList = [];

  //This learn from a tutorial - This method is used to add documents to the blog collection
  Future<String> addBlog(String authorName, String title, String description,
      Uint8List file) async {
    String res = "Success";
    String id = generateId();
    try {
      /* This blogPicUrl variable will get image url which is uploaded to the firebase storage.
      and then it will pass to json object. Then the image url and all the relavent information will send as a json object to firebase firestore. 
      Then it will save in blogs collection as a new document.
       */
      String blogPicUrl =
          await BlogStorageServices().uploadImgToStorage('blog', file);
      Map<String, dynamic> blogDetails = {
        "id": id,
        "authorName": authorName,
        "title": title,
        "description": description,
        "blogPicUrl": blogPicUrl
      };

      await _firestore.collection("blogs").doc(id).set(blogDetails);
    } catch (e) {
      return e.toString();
    }

    return res;
  }

/*Learn from a tutorial - this method will get all the blogs from the firebase. */
  Future getBlogs() async {
    try {
      await _firestore.collection("blogs").get().then((quertSnapshot) {
        for (var result in quertSnapshot.docs) {
          blogList.add(result.data());
          debugPrint("blogList - $blogList");
        }
      });

      return blogList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}
