import 'package:flutter/material.dart';
import 'package:help_me_store/Model/projects_Model.dart';
import 'package:help_me_store/Model/tasks_Model.dart';
import 'package:help_me_store/Pages/myWorks_detail.dart';

import 'package:help_me_store/Widgets/font.dart';
import 'package:help_me_store/Widgets/input_field.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyWorksPage extends StatefulWidget {
  @override
  State<MyWorksPage> createState() => _MyWorksState();
}

class _MyWorksState extends State<MyWorksPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            'My Work',
            style: headingTextStyleWhite,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Assigned'),
              Tab(text: 'Accept'),
              Tab(text: 'Finish'),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.blueGrey,
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            // Assigned Tab
            Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                String loggedInUserId =
                    'getCurrentLoggedInUserId()'; // Get the logged-in user's ID

                List<Task> relevantTasks = taskProvider.tasks.where((task) {
                  return task.assignedEmployeeId ==
                          loggedInUserId && // Check if the task is assigned to the logged-in user
                      task.status ==
                          TaskStatus
                              .assigned; // Adjust this based on the tab (assigned, accepted, finished)
                }).toList();
                final projectProvider =
                    Provider.of<ProjectProvider>(context, listen: false);
                List<Task> assignedTasks = taskProvider.tasks.where((task) {
                  return task.status == TaskStatus.assigned &&
                      (task.serviceteam != '' ||
                          task.serviceteam!.isNotEmpty) &&
                      task.date != null &&
                      task.date!.day == DateTime.now().day &&
                      task.date!.month == DateTime.now().month &&
                      task.date!.year == DateTime.now().year;
                }).toList();

                return ListView.builder(
                  itemCount: assignedTasks.length,
                  itemBuilder: (context, index) {
                    final task = assignedTasks[index];
                    Project? project;
                    String customerName = 'No Customer';
                    String projectName = 'No Project';

                    if (task.projectId != null) {
                      project = projectProvider.getProjectById(task.projectId!);
                      customerName = project?.customer.company ?? 'No Customer';
                      projectName = project?.projectName ?? 'No Project';
                    }

                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        color: Colors.grey[200],
                        shadowColor: Colors.grey[600],
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: Icon(Icons.work, color: Colors.grey[600]),
                          title: Text(task.taskType ?? 'No Task Type'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat('dd/MM/yyyy')
                                  .format(task.date ?? DateTime.now())),
                              Text('Project: $projectName'),
                              Text('Customer: $customerName'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.check_circle_rounded,
                                    color: Colors.green),
                                onPressed: () {
                                  taskProvider.updateTaskStatus(
                                      task.Id, TaskStatus.accepted);
                                },
                              ),
                              IconButton(
                                icon:
                                    Icon(Icons.cancel, color: Colors.redAccent),
                                onPressed: () {
                                  taskProvider.updateTaskServiceTeam(
                                      task.Id, task.serviceteam ?? '');
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ViewTaskPage(task: task),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // Assigned Tab
            Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                final projectProvider =
                    Provider.of<ProjectProvider>(context, listen: false);
                List<Task> acceptedTasks = taskProvider.tasks.where((task) {
                  return task.status == TaskStatus.accepted &&
                      (task.serviceteam != '' ||
                          task.serviceteam!.isNotEmpty) &&
                      task.date != null &&
                      task.date!.day == DateTime.now().day &&
                      task.date!.month == DateTime.now().month &&
                      task.date!.year == DateTime.now().year;
                }).toList();

                return ListView.builder(
                  itemCount: acceptedTasks.length,
                  itemBuilder: (context, index) {
                    final task = acceptedTasks[index];
                    Project? project;
                    String customerName = 'No Customer';
                    String projectName = 'No Project';

                    if (task.projectId != null) {
                      project = projectProvider.getProjectById(task.projectId!);
                      customerName = project?.customer.company ?? 'No Customer';
                      projectName = project?.projectName ?? 'No Project';
                    }

                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        color: Colors.grey[200],
                        shadowColor: Colors.grey[600],
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: Icon(
                            Icons.work_history,
                            color: Colors.yellow[800],
                          ),
                          title: Text(task.taskType ?? 'No Task Type'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat('dd/MM/yyyy')
                                  .format(task.date ?? DateTime.now())),
                              Text(
                                  'Project: ${project?.projectName ?? 'No Project'}'),
                              Text('Customer: $customerName'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.work, color: Colors.grey[600]),
                                onPressed: () {
                                  taskProvider.updateTaskStatus(
                                      task.Id, TaskStatus.assigned);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.check_circle,
                                    color: Colors.blueAccent),
                                onPressed: () {
                                  taskProvider.updateTaskStatus(
                                      task.Id, TaskStatus.finished);
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ViewTaskPage(task: task),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // Finish Tab
            Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                final projectProvider =
                    Provider.of<ProjectProvider>(context, listen: false);
                List<Task> finishedTasks = taskProvider.tasks.where((task) {
                  return task.status == TaskStatus.finished &&
                      task.date != null &&
                      task.date!.day == DateTime.now().day &&
                      task.date!.month == DateTime.now().month &&
                      task.date!.year == DateTime.now().year;
                }).toList();

                return ListView.builder(
                  itemCount: finishedTasks.length,
                  itemBuilder: (context, index) {
                    final task = finishedTasks[index];
                    Project? project;
                    String customerName = 'No Customer';
                    String projectName = 'No Project';

                    if (task.projectId != null) {
                      project = projectProvider.getProjectById(task.projectId!);
                      customerName = project?.customer.company ?? 'No Customer';
                      projectName = project?.projectName ?? 'No Project';
                    }

                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        color: Colors.grey[200],
                        shadowColor: Colors.grey[600],
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading:
                              Icon(Icons.check_circle, color: Colors.green),
                          title: Text(task.taskType ?? 'No Task Type'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat('dd/MM/yyyy')
                                  .format(task.date ?? DateTime.now())),
                              Text('Project: $projectName'),
                              Text('Customer: $customerName'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.work_history,
                                color: Colors.yellow[800]),
                            onPressed: () {
                              // Call the method to change the task status back to 'Accepted'
                              taskProvider.updateTaskStatus(
                                  task.Id, TaskStatus.accepted);
                            },
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ViewTaskPage(task: task),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
