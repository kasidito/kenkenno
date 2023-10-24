import 'package:http/http.dart';
import 'package:is_767/models/todo_model.dart';
import 'dart:convert';

class TodoHttpService {
  Client client = Client();

  Future<List<Todo>> getTodos() async {
    final response = await client.get(
      Uri.parse('http://jsonplaceholder.typicode.com/todos'),
    );

    if (response.statusCode == 200) {
      var all = AllTodos.fromJson(json.decode(response.body));
      return all.todos;
    } else {
      throw Exception('Fall to load todos');
    }
  }
}
