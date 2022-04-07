import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_blog.dart';
import 'all_blogs.dart';
import 'single_blog_page.dart';

/*Created by - IT19246024 - Warnakulasuriya D.A*/
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //This will read all the current documents of blogs collection
  final Stream<QuerySnapshot> _firebase =
      FirebaseFirestore.instance.collection('blogs').snapshots();

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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AllBlogs()));
              },
              icon: const Icon(
                Icons.article_outlined,
                color: Colors.amber,
              ))
        ],
      ),
      //Learn from a tutorial - the stream bulder widget will build itself on the latest snapshot of the firebase databse.
      body: StreamBuilder(
        stream: _firebase,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //if the latest snapshot has error this will indicates that somthing is wrong
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          //when the data is loading this will display circular progress indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          //This will return the data fetch from the database and display it as a list
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      //Learn from a tutorial - this method will send relavent document and document id to the single blog page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SingleBlogPage(
                              documentid: snapshot.data!.docs[index]),
                        ),
                      );
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                              elevation: 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        snapshot.data!.docChanges[index]
                                            .doc['blogPicUrl'],
                                        width: 390,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              snapshot.data!.docChanges[index]
                                                  .doc['title'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            snapshot.data!.docChanges[index]
                                                .doc['authorName'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            snapshot.data!.docChanges[index]
                                                .doc['description'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ]),
                                  )
                                ],
                              ))
                        ]),
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
                    MaterialPageRoute(builder: (context) => const AddBlog()));
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
