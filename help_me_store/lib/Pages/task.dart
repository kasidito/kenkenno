import 'package:flutter/material.dart';

import 'package:help_me_store/Model/projects_Model.dart';
import 'package:help_me_store/Model/tasks_Model.dart';

import 'package:help_me_store/Pages/task_add.dart';
import 'package:help_me_store/Pages/task_edit.dart';

import 'package:help_me_store/Widgets/font.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//1. Front
class CreateTask extends StatefulWidget {
  final String projectId;

  CreateTask({required this.projectId});

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            'Tasks',
            style: headingTextStyle,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add_circle_outline_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          AddTaskPage(projectId: widget.projectId)),
                );
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'To be Assigned'),
              Tab(text: 'Assigned'),
              Tab(text: 'Finish'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // To be Assigned Tab
            ListView.builder(
              itemCount: taskProvider.tasks
                  .where((task) =>
                      task.projectId ==
                          widget.projectId && // Filter by projectId
                      (task.serviceteam == '' ||
                          task.serviceteam == null ||
                          task.serviceteam!.isEmpty))
                  .length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks
                    .where((task) =>
                        task.projectId ==
                            widget.projectId && // Filter by projectId
                        (task.serviceteam == '' ||
                            task.serviceteam == null ||
                            task.serviceteam!.isEmpty))
                    .elementAt(index);
                return buildTaskCard(task, taskProvider);
              },
            ),
            // Assigned Tab
            ListView.builder(
              itemCount: taskProvider.tasks
                  .where((task) =>
                      task.projectId ==
                          widget.projectId && // Filter by projectId
                      task.serviceteam != null &&
                      task.serviceteam!.isNotEmpty)
                  .length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks
                    .where((task) =>
                        task.projectId ==
                            widget.projectId && // Filter by projectId
                        task.serviceteam != null &&
                        task.serviceteam!.isNotEmpty)
                    .elementAt(index);
                return buildTaskCard(task, taskProvider);
              },
            ),

// Finish Tab
            ListView.builder(
              itemCount: taskProvider.tasks
                  .where((task) =>
                      task.projectId ==
                          widget.projectId && // Filter by projectId
                      task.serviceteam != null &&
                      task.serviceteam!.isNotEmpty &&
                      task.status == TaskStatus.finished)
                  .length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks
                    .where((task) =>
                        task.projectId ==
                            widget.projectId && // Filter by projectId
                        task.serviceteam != null &&
                        task.serviceteam!.isNotEmpty &&
                        task.status == TaskStatus.finished)
                    .elementAt(index);
                return buildTaskCard(task, taskProvider);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTaskCard(Task task, TaskProvider taskProvider) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        color: Colors.grey[200],
        shadowColor: Colors.grey[600],
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Icon(Icons.work_outline),
          title: Text(task.taskType ?? 'No Task Type',
              style: titleTextStle.copyWith(
                  color: task.status == TaskStatus.finished
                      ? Colors.grey
                      : Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.serviceteam ?? 'No Service Team'),
              Text(
                  DateFormat('dd/MM/yyyy').format(task.date ?? DateTime.now())),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Task'),
                  content: Text('Are you sure you want to delete this task?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Dismiss the dialog
                      },
                    ),
                    TextButton(
                      child: Text('Delete'),
                      onPressed: () {
                        taskProvider.removeTask(task.Id);
                        Navigator.of(context).pop(); // Dismiss the dialog
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    EditTaskPage(task: task, isViewOnly: false),
              ),
            );
          },
        ),
      ),
    );
  }
}
