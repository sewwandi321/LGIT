import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_git/screens/addquestions.dart';
import 'package:learn_git/screens/editquestion.dart';

/**
 * created by IT19159072 A.N.S.Thenuwara
 */
class QuestionList extends StatefulWidget {
  const QuestionList({Key? key}) : super(key: key);

  @override
  State<QuestionList> createState() => _QuestionListState();
}

/**
 * read all the current question of the document
 */
class _QuestionListState extends State<QuestionList> {
  final Stream<QuerySnapshot> _firebase =
      FirebaseFirestore.instance.collection('questions').snapshots();

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
      /**
       * Stream builder build the newst version of the firebase database it self
       */
      body: StreamBuilder(
        stream: _firebase,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //if the snapshot is give error it will shows an error msg
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          //In here circularProgressIndicator shows when the data is loading
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
             * all the questions are display as a listview 
             * when we click it it goes to question details such as image of question 
             * and the title and content
             */
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: (snapshot.data! as dynamic).docs.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    //On the onTap function when we click on a question it will navigate to edit page of perticular
                    //  question
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditQuestion(
                            documentid: snapshot.data!.docs[index]),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        (snapshot.data! as dynamic).docs[index]['question'],
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddQuestion()));
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
