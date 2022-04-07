import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_git/screens/addNotes.dart';
import 'package:learn_git/screens/notelist.dart';

/**
 * created by IT19129518 Rathnayake R.M.D.M
 * learn from tutorial - All Notes class will send the specific document id
 * If user wants to edit the deails user can  edit title and content
 * Edit notes class will get that document id and extract the details 
 */
class EditNote extends StatefulWidget {
  late DocumentSnapshot documentid;

  EditNote({required this.documentid});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    //the title and content will save in  the specific variable
    title = TextEditingController(text: widget.documentid.get('title'));
    content = TextEditingController(text: widget.documentid.get('content'));
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
      body: Column(
        children: [
          Container(),
          Form(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Container(
                child: Column(
                  children: [
                    Center(),
                    Padding(
                      //child: Text("Title:"),
                      padding: EdgeInsets.fromLTRB(0, 2, 260, 2),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextField(
                        controller: title,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                          hintText: 'title',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      //child: Text("Content:"),
                      padding: EdgeInsets.fromLTRB(0, 2, 220, 2),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextField(
                        maxLines: 8,
                        controller: content,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
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
                                'question': title.text,
                                'content': content.text,
                              }).whenComplete(() {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => NoteList()));
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
                                        builder: (_) => NoteList()));
                              });
                            },
                            icon: const Icon(Icons.delete),
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
        ],
      ),
    );
  }
}
