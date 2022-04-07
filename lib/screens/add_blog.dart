import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/blog_service.dart';
import '../util/add_image.dart';
import 'home.dart';

/*Created by - IT19246024 - Warnakulasuriya D.A*/
class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final authNameController = TextEditingController();
  final titleController = TextEditingController();
  final descController = TextEditingController();

  Uint8List? _image;

  BlogService blogService = new BlogService();

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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () async {
                  /* Learn from a tutorial - This img variable holds the image got from the gallery. 
                  Then set that image to _image variable. 
                  when user choose different image that image will save in img variable and set it _image variable  */
                  Uint8List img = await pickImage();
                  setState(() {
                    _image = img;
                  });
                },
                /*Learn from a tutorial - If Image is not null image will display otherwise white container will display */
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
                    decoration: const InputDecoration(hintText: "Author Name"),
                    controller: authNameController,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Title"),
                    controller: titleController,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Description"),
                    controller: descController,
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      blogService
                          .addBlog(
                              authNameController.text,
                              titleController.text,
                              descController.text,
                              _image!)
                          .whenComplete(() {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (_) => Home()));
                      });
                      // Navigator.pop(context);
                    },
                    child: const Text('Upload Post'),
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
