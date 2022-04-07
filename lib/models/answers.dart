class Answers {
  late String id;
  late String answer;
  late String pid;

  Answers({
    required this.id,
    required this.answer,
    required this.pid,
  });

  Map<String, dynamic> toConvertJson() =>
      {"id": id, "answer": answer, "pid": pid};

  Answers.fromSnapshot(snapshot)
      : id = snapshot.data()['id'],
        answer = snapshot.data()['answer'],
        pid = snapshot.data()['pid'];
}
