class Todo {
  const Todo({required this.id, required this.title, this.completed = false});

  final String id;
  final String title;
  final bool completed;

  Todo getTodo({bool? completed, String? title}) {
    return Todo(
      id: id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
