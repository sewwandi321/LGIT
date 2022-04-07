import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home.dart';

/*Created by - IT19246024 - Warnakulasuriya D.A*/
/** Learn from a tutorial - home will send the specific document id user wants to view to the read the blog class. 
The edit blog class will get that document id and extract the details of the specific document. */
class SingleBlogPage extends StatefulWidget {
  late DocumentSnapshot documentid;
  SingleBlogPage({required this.documentid});

  @override
  State<SingleBlogPage> createState() => _SingleBlogPageState();
}

class _SingleBlogPageState extends State<SingleBlogPage> {
  late String title;
  late String description;
  late String authorName;
  late String imgUrl;

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
  void initState() {
    //the relavent data of the document will save in the specific variable
    title = widget.documentid.get('title');
    description = widget.documentid.get('description');
    authorName = widget.documentid.get('authorName');
    imgUrl = widget.documentid.get('blogPicUrl');
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
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
                    imgUrl,
                    width: 390,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white)),
                      SizedBox(
                        height: 3,
                      ),
                      Text(authorName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white)),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 350,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()));
                          },
                          child: const Text('Back to Home'),
                          style: btnstyle,
                        ),
                      )
                    ]),
              )
            ]),
      ),
    );
  }
}
