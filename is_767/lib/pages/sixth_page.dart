import 'package:flutter/material.dart';
import 'package:is_767/controllers/todo_controller.dart';
import 'package:is_767/models/todo_model.dart';
import 'package:is_767/services/todo_service.dart';

class SixthPage extends StatefulWidget {
  @override
  State<SixthPage> createState() => _SixthPageState();
}

class _SixthPageState extends State<SixthPage> {
  List<Todo> todos = List.empty();
  bool isLoading = false;
  TodoController controller = TodoController(TodoHttpService());

  @override
  void initState() {
    super.initState();
    controller.onSync.listen((bool syncState) {
      setState(() {
        isLoading = syncState;
      });
    });
  }

  void _getTodos() async {
    var newTodos = await controller.fetchTodos();

    setState(() {
      todos = newTodos;
    });
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: todos.isNotEmpty ? todos.length : 1,
          itemBuilder: (context, index) {
            if (todos.isNotEmpty) {
              return CheckboxListTile(
                title: Text(todos[index].title),
                value: todos[index].completed,
                onChanged: (value) {},
              );
            }

            return Center(
              child: Text('Tap button to fetch todos'),
            );
          },
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Todo'),
      ),
      body: Center(
        child: body,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getTodos,
        child: Icon(Icons.add),
      ),
    );
  }
}
