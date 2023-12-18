import 'package:flutter/material.dart';
import 'package:help_me_store/Model/tasks_Model.dart';
import 'package:provider/provider.dart';
import 'package:help_me_store/Widgets/font.dart';

class JobBoardPage extends StatefulWidget {
  @override
  State<JobBoardPage> createState() => _JobBoardPageState();
}

class _JobBoardPageState extends State<JobBoardPage> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    List<Task> unassignedTasks = taskProvider.getUnassignedTasks();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Job Board', style: headingTextStyle),
      ),
      body: unassignedTasks.isEmpty
          ? Center(
              child: Text('No available tasks', style: TextStyle(fontSize: 24)))
          : ListView.builder(
              itemCount: unassignedTasks.length,
              itemBuilder: (context, index) {
                Task task = unassignedTasks[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.work_outline,
                        color: Theme.of(context).primaryColor),
                    title: Text(task.taskType ?? 'No Task Type',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    // subtitle:
                    //     Text('Project: ${task.projectName ?? 'No Project'}'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // TODO: Implement your functionality for task selection
                      print('Task selected: ${task.Id}');
                    },
                  ),
                );
              },
            ),
    );
  }
}
