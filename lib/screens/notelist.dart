import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_git/screens/addNotes.dart';
import 'package:learn_git/screens/addquestions.dart';
import 'package:learn_git/screens/editnote.dart';
import 'package:learn_git/screens/editquestion.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final Stream<QuerySnapshot> _firebase =
      FirebaseFirestore.instance.collection('notes').snapshots();

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
      body: StreamBuilder(
        stream: _firebase,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            /**
             * Learn from tutorial
             * all the notes are display as a listview 
             * when we click it it goes to notes details 
             * and the title and content
             */
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: (snapshot.data! as dynamic).docs.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            EditNote(documentid: snapshot.data!.docs[index]),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        (snapshot.data! as dynamic).docs[index]['title'],
                      ),
                    ),
                  );
                }),
          );
        },
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddNote()));
              },
              backgroundColor: const Color(0xFF1C7EE7),
              child: const Icon(
                Icons.mode_edit,
              ),
            )
          ],
        ),
      ),
    );
  }
}
