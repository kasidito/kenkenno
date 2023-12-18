import 'package:flutter/material.dart';
import 'package:help_me_store/Model/projects_Model.dart';
import 'package:help_me_store/Pages/project_detail.dart';
import 'package:help_me_store/Pages/task.dart';

import 'package:provider/provider.dart';
import 'package:help_me_store/Pages/project_add.dart';
import 'package:help_me_store/Widgets/font.dart';
import 'package:intl/intl.dart';

class ProjectServicePage extends StatefulWidget {
  @override
  _ProjectServiceState createState() => _ProjectServiceState();
}

class _ProjectServiceState extends State<ProjectServicePage> {
  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);

    return DefaultTabController(
      length: 3, // Number of tabs for different project statuses
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Projects List (Service)', style: headingTextStyle),
          bottom: TabBar(
            onTap: (index) async {
              await Future.delayed(
                  Duration(milliseconds: 400)); // Adjust the delay as needed
              DefaultTabController.of(context)!.animateTo(index);
            },
            tabs: [
              Tab(text: 'Planning'),
              Tab(text: 'In Progress'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildProjectList(projectProvider, ProjectStatus.planning),
            buildProjectList(projectProvider, ProjectStatus.inProgress),
            buildProjectList(projectProvider, ProjectStatus.completed),
          ],
        ),
      ),
    );
  }

  Widget buildProjectList(ProjectProvider provider, ProjectStatus status) {
    final projects =
        provider.projects.where((p) => p.status == status).toList();

    return projects.isEmpty
        ? Center(child: Text('No projects in this category.'))
        : ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              IconData statusIcon;
              switch (project.status) {
                case ProjectStatus.planning:
                  statusIcon =
                      Icons.play_arrow; // Icon for starting the project
                  break;
                case ProjectStatus.inProgress:
                  statusIcon = Icons.check; // Icon for completing the project
                  break;
                case ProjectStatus.completed:
                  statusIcon = Icons.loop; // Icon for resetting to planning
                  break;
                default:
                  statusIcon = Icons.help_outline; // Default icon
              }

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  color: Colors.grey[200],
                  shadowColor: Colors.grey[600],
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.work_outline),
                    title: Text(project.projectName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(project.projectType ?? 'No Project Type'),
                        Text(DateFormat('dd/MM/yyyy')
                            .format(project.startDate ?? DateTime.now())),
                        if (project.customer != null) ...[
                          SizedBox(height: 4),
                          Text('Customer: ${project.customer.company}'),
                        ],
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(statusIcon, color: Colors.blueAccent),
                          onPressed: () {
                            _updateProjectStatus(project, provider);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Delete Project'),
                                content: Text(
                                    'Are you sure you want to delete this project?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () {
                                      provider.removeProject(project);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      print(project.Id);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailProjectPage(project: project),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
  }

  void _updateProjectStatus(Project project, ProjectProvider provider) {
    ProjectStatus newStatus;
    switch (project.status) {
      case ProjectStatus.planning:
        newStatus = ProjectStatus.inProgress;
        break;
      case ProjectStatus.inProgress:
        newStatus = ProjectStatus.completed;
        break;
      case ProjectStatus.completed:
        newStatus = ProjectStatus.planning;
        break;
      default:
        newStatus = project.status;
    }

    provider.updateProjectStatus(project.Id, newStatus);
  }
}
