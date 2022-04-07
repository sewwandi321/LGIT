/*Created by - IT19246024 - Warnakulasuriya D.A*/
class Blog {
  late String id;
  late String authorName;
  late String title;
  late String description;
  late String blogPicUrl;

  Blog(
      {required this.id,
      required this.authorName,
      required this.title,
      required this.description,
      required this.blogPicUrl});

/* Learn from a tutorial - This method will use to convert to JSON object*/
  Map<String, dynamic> toConvertJson() => {
        "id": id,
        "authorName": authorName,
        "title": title,
        "description": description,
        "blogPicUrl": blogPicUrl
      };

  /*Learn from a tutorial - convert snapshot to blog model */
  Blog.fromSnapshot(snapshot)
      : id = snapshot.data()['id'],
        authorName = snapshot.data()['authorName'],
        title = snapshot.data()['title'],
        description = snapshot.data()['description'],
        blogPicUrl = snapshot.data()['blogPicUrl'];
}
