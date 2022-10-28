import 'package:localstore/localstore.dart';

class Todo {
  final String id;
  String title;
  String time;
  bool done;

  Todo({
    required this.id,
    required this.title,
    required this.time,
    required this.done,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'done': done,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      time: map['time'],
      done: map['done'],
    );
  }
}

extension ExtTodo on Todo {
  Future save() async {
    final _db = Localstore.instance;
    return _db.collection('todos').doc(id).set(toMap());
  }
}
