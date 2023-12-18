import 'package:flutter/material.dart';
import 'package:help_me_store/Model/projects_Model.dart';
import 'package:help_me_store/Model/tasks_Model.dart';

import 'package:help_me_store/Pages/project_edit.dart';
import 'package:help_me_store/Pages/task.dart';
import 'package:help_me_store/Widgets/font.dart';
import 'package:intl/intl.dart';

class DetailProjectPage extends StatefulWidget {
  final Project project;

  DetailProjectPage({required this.project});

  @override
  State<DetailProjectPage> createState() => _DetailProjectPageState();
}

class _DetailProjectPageState extends State<DetailProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Project Detail',
          style: headingTextStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          EditProjectPage(project: widget.project),
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Project Name: ${widget.project.projectName}',
                            style: subHeadingTextStyle),
                        SizedBox(height: 10),
                        Text('Type: ${widget.project.projectType}',
                            style: subTitleTextStle),
                        SizedBox(height: 5),
                        Text(
                            'Date: ${DateFormat.yMd().format(widget.project.startDate!)}',
                            style: subTitleTextStle),
                        SizedBox(height: 5),
                        Text('Details: ${widget.project.projectDetails}',
                            style: subTitleTextStle),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                shadowColor: Colors.grey[600],
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Icon(Icons.work_outline),
                  title: Text(
                    'Manage Tasks',
                    style: titleTextStle,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            CreateTask(projectId: widget.project.Id),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              // Mock data
              Card(
                shadowColor: Colors.grey[600],
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('List of Materials Used', style: titleTextStle),
                      SizedBox(height: 10),
                      Text('4 Air Filters', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      Text('2 Air Filters', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      Text('2 Oils', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
