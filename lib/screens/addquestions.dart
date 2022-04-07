import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:learn_git/screens/questionlist.dart';
import 'package:learn_git/services/question_service.dart';
import 'package:learn_git/util/add_image.dart';

import 'package:image_picker/image_picker.dart';

/**
 * created by IT19159072 A.N.S.Thenuwara
 */
class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestiontate();
}

class _AddQuestiontate extends State<AddQuestion> {
  final questionController = TextEditingController();
  final contentController = TextEditingController();

  Uint8List? _image;

  QuestionService questionService = new QuestionService();

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
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.article_outlined,
                color: Colors.amber,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                /**
               * Learn from tutorial 
               * The img variable has the image that we get from the gallery
               * Then set that image to _image variable.
               * 
               */
                onTap: () async {
                  Uint8List img = await pickImage();
                  setState(() {
                    _image = img;
                  });
                },
                /**
                 * if image is not null then image is display or else white container will display 
                 */
                child: _image != null
                    ? SizedBox(
                        width: 350,
                        height: 150,
                        child: Image.memory(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: 350,
                        height: 150,
                        decoration: BoxDecoration(
                            color: const Color(0xFFEEEEEE),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFFFFEFE),
                              )
                            ],
                            borderRadius: BorderRadius.circular(5)),
                        child: const Icon(
                          Icons.add_a_photo,
                          color: Colors.black45,
                        ),
                      )),
            const SizedBox(
              height: 8,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                        hintText: "Question"),
                    controller: questionController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    maxLines: 8,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                        hintText: "Content"),
                    controller: contentController,
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      questionService.addQuestion(questionController.text,
                          contentController.text, _image!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuestionList()));
                    },
                    child: const Text('Upload Question'),
                    style: btnstyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
