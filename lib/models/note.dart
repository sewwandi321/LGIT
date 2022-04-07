// /**
//  * created by IT19129518 Rathnayake R.M.D.M
//  */
// class Note {
//   late String id;
//   late String title;
//   late String content;

//   Note(
//       {required this.id,
//       required this.title,
//       required this.content,});

//   /**
//    * From tutorial
//    * This method used to convert to a object file
//    */
//   Map<String, dynamic> toConvertJson() => {
//         "id": id,
//         "question": title,
//         "content": content,
//       };

//   Note.fromSnapshot(snapshot)
//       : id = snapshot.data()['id'],
//         title = snapshot.data()['title'],
//         content = snapshot.data()['content']
// }
/*Created by - IT19246024 - Warnakulasuriya D.A*/
class Blog {
  late String id;
  late String title;
  late String content;

  Blog({
    required this.id,
    required this.title,
    required this.content,
  });

/* Learn from a tutorial - This method will use to convert to JSON object*/
  Map<String, dynamic> toConvertJson() =>
      {"id": id, "title": title, "content": content};

  Blog.fromSnapshot(snapshot)
      : id = snapshot.data()['id'],
        title = snapshot.data()['title'],
        content = snapshot.data()['content'];
}
