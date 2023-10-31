import 'package:http/http.dart';
import 'package:is_767/models/todo_model.dart';
import 'dart:convert';

class TodoHttpService {
  Client client = Client();

  Future<List<Todo>> getTodos() async {
    try {
      final response = await client.get(
        Uri.parse('http://jsonplaceholder.typicode.com/todos'),
      );

      if (response.statusCode == 200) {
        var all = AllTodos.fromJson(json.decode(response.body));
        return all.todos;
      } else {
        throw Exception('Fall to load todos');
      }
    } catch (e) {
      throw Exception("Error while connect to backend");
    }
  }

  void updateTodos(Todo todo) async {
    final response = await client.put(
      Uri.parse('http://jsonplaceholder.typicode.com/todos/${todo.id}'),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "userId": todo.userId,
        "id": todo.id,
        "title": todo.title,
        "complete": todo.completed,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception("Connot update todo");
    }
    print(response.body);
  }
}
