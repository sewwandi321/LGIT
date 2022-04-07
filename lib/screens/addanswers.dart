import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:learn_git/screens/questionlist.dart';
import 'package:learn_git/services/comment_service.dart';
import 'package:learn_git/utill/colors.dart';

/**
 * created by IT19159072 A.N.S.Thenuwara
 */
class AddAnswers extends StatefulWidget {
  final String postId;
  const AddAnswers({Key? key, required this.postId}) : super(key: key);

  @override
  State<AddAnswers> createState() => _AddAnswerstate();
}

class _AddAnswerstate extends State<AddAnswers> {
  final TextEditingController answerController = TextEditingController();

  AnswerService answerService = new AnswerService();
  String? comment = "";

  final ButtonStyle btnstyle = ElevatedButton.styleFrom(
    primary: const Color(0xFF1C7EE7),
    fixedSize: const Size(350, 40),
    textStyle: const TextStyle(
      fontFamily: 'Poppins',
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    side: const BorderSide(
      color: Colors.transparent,
      width: 1,
    ),
  );
  /**
   * In here we create a method call postComment we pass the postID and answer 
   * If result is success we set the answer answer  and if it gives and error we print the error
   */
  void postComment() async {
    comment = answerController.text;

    print(answerController.text);
    print(widget.postId);
    try {
      String res = await AnswerService().postComment(
        widget.postId,
        answerController.text,
      );
      print("comment");
      print(comment);

      if (res != 'success') {
        print("sucess");
      }
      setState(() {
        answerController.text = "";
      });
    } catch (err) {
      // print("dewwwwwww err");
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        title: const Text(
          'Comments',
        ),
        centerTitle: false,
      ),
      body: StreamBuilder(
        /**
         * In here inside the collection table we create another collection called comments.
         * In there we store all the comments in that question
         */
        stream: FirebaseFirestore.instance
            .collection('questions')
            .doc(widget.postId)
            .collection('comments')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
            //print(object)
          }
/**
 * When we add the answer for the perticular question user can view it as a listview
 */
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) => ListTile(
                    title: Text(
                      (snapshot.data! as dynamic).docs[index]['text'],
                    ),
                  ));
        },
      ),
      // text input
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: answerController,
                    decoration: const InputDecoration(
                      hintText: 'Comment',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => postComment(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
