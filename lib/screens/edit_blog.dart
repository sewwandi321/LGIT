import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home.dart';

/*Created by - IT19246024 - Warnakulasuriya D.A*/
/*Learn from a tutorial - All blogs class will send the specific document id user wants to edit to the edit blog class. 
The edit blog class will get that document id and extract the details of the specific document. */
class EditBlog extends StatefulWidget {
  late DocumentSnapshot documentid;

  EditBlog({required this.documentid});

  @override
  State<EditBlog> createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  late String imgUrl;

  final ButtonStyle btnstyle = ElevatedButton.styleFrom(
    primary: Colors.green,
  );

  @override
  void initState() {
    //the relavent data of the document will save in the specific variable
    title = TextEditingController(text: widget.documentid.get('title'));
    description =
        TextEditingController(text: widget.documentid.get('description'));
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
            Form(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        child: Text("Title:"),
                        padding: EdgeInsets.fromLTRB(0, 2, 260, 2),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          controller: title,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                            hintText: 'title',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 220, 2),
                        child: Text("Description:"),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          maxLines: 8,
                          controller: description,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                            hintText: 'description',
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                /* Learn from a tutorial - This will update the title and description. after update it will navigate to Home page */
                                widget.documentid.reference.update({
                                  'title': title.text,
                                  'description': description.text,
                                }).whenComplete(() {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Home()));
                                });
                              },
                              child: Text(
                                "UPDATE POST",
                              ),
                              style: btnstyle,
                            ),
                            IconButton(
                              onPressed: () {
                                /* Learn from a tutorial - This will delete the document. after delete it will navigate to Home page */
                                widget.documentid.reference
                                    .delete()
                                    .whenComplete(() {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Home()));
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
      ),
    );
  }
}
