import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_git/screens/addanswers.dart';
import 'package:learn_git/screens/questionlist.dart';
//import 'package:learn_git/screens/questionlist.dart';

/**
 * created by IT19159072 A.N.S.Thenuwara
 * learn from tutorial - All question class will send the specific document id
 * If user wants to edit the deails user can  edit question and content
 * Edit question class will get that document id and extract the details 
 */
class EditQuestion extends StatefulWidget {
  late DocumentSnapshot documentid;

  EditQuestion({required this.documentid});

  @override
  State<EditQuestion> createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  TextEditingController question = TextEditingController();
  TextEditingController content = TextEditingController();

  Uint8List? _image;
  late String imgUrl;
  late String postId = "";

  @override
  void initState() {
    //the question and content will save in  the specific variable
    postId = widget.documentid.get('id');
    question = TextEditingController(text: widget.documentid.get('question'));
    content = TextEditingController(text: widget.documentid.get('content'));
    imgUrl = widget.documentid.get('blogPicUrl');
    print("postId9999999999999999999999");
    print(postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Learn Git",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.5,
      ),
      body: Scrollbar(
        child: Column(
          children: [
            Container(),
            Form(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Container(
                  child: Column(
                    children: [
                      Center(
                          child: Image.network(imgUrl,
                              fit: BoxFit.fitHeight, height: 100, width: 80)),
                      const Padding(
                        //child: Text("Question:"),
                        padding: EdgeInsets.fromLTRB(0, 2, 200, 2),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: question,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 10),
                            hintText: 'question',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        //child: Text("Content:"),
                        padding: EdgeInsets.fromLTRB(0, 2, 110, 2),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          maxLines: 4,
                          controller: content,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 10),
                            hintText: 'content',
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                widget.documentid.reference.update({
                                  'question': question.text,
                                  'content': content.text,
                                }).whenComplete(() {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => QuestionList()));
                                });
                              },
                              icon: const Icon(Icons.update),
                              color: Colors.red,
                            ),
                            IconButton(
                              onPressed: () {
                                widget.documentid.reference
                                    .delete()
                                    .whenComplete(() {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => QuestionList()));
                                });
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddAnswers(postId: postId)));
                              },
                              icon: const Icon(Icons.add),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
