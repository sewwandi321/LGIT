import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:learn_git/screens/editnote.dart';
import 'package:learn_git/screens/notelist.dart';
import 'package:learn_git/services/note_service.dart';

/**
 * created by IT19129518 Rathnayake R.M.D.M
 */
class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  NoteService noteservice = new NoteService();

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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                        hintText: "Title"),
                    controller: titleController,
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
                      noteservice.addNote(
                          titleController.text, contentController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NoteList()));
                    },
                    child: const Text('Upload Note'),
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
