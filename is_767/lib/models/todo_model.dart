class Todo {
  final int userId;
  int id;
  final String title;
  bool completed;

  Todo(this.userId, this.id, this.title, this.completed);

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      json['userId'] as int,
      json['id'] as int,
      json['title'] as String,
      json['completed'] as bool,
    );
  }
}

class AllTodos {
  final List<Todo> todos;

  AllTodos(this.todos);

  factory AllTodos.fromJson(List<dynamic> json) {
    List<Todo> todos;
    //Get one data at a time.
    todos = json.map((item) => Todo.fromJson(item)).toList();

    return AllTodos(todos);
  }
}
