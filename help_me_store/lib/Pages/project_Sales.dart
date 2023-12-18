import 'package:flutter/material.dart';
import 'package:help_me_store/Model/projects_Model.dart';
import 'package:help_me_store/Pages/project_detail.dart';

import 'package:provider/provider.dart';
import 'package:help_me_store/Pages/project_add.dart';
import 'package:help_me_store/Widgets/font.dart';
import 'package:intl/intl.dart';

class ProjectSalesPage extends StatefulWidget {
  @override
  _ProjectSalesPageState createState() => _ProjectSalesPageState();
}

class _ProjectSalesPageState extends State<ProjectSalesPage> {
  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);

    return DefaultTabController(
      length: 3, // Number of tabs for different project statuses
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Projects List (Sales)', style: headingTextStyle),
          actions: [
            IconButton(
              icon: Icon(Icons.add_circle_outline_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddProjectPage()),
                );
              },
            ),
          ],
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
                        if (project.customer != '') ...[
                          SizedBox(height: 4),
                          Text('Customer: ${project.customer!.company}'),
                        ],
                      ],
                    ),
                    trailing: IconButton(
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
                                onPressed: () => Navigator.of(context).pop(),
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
                    onTap: () {
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
}
