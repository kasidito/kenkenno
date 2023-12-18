import 'package:flutter/material.dart';
import 'package:help_me_store/Model/projects_Model.dart';
import 'package:help_me_store/Model/serviceReport_Model.dart';
import 'package:help_me_store/Model/tasks_Model.dart';
import 'package:help_me_store/Pages/serviceReport.dart';
import 'package:help_me_store/Pages/serviceReport_detail.dart';
import 'package:help_me_store/Pages/serviceReport_history.dart';
import 'package:help_me_store/Widgets/font.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewTaskPage extends StatelessWidget {
  final Task task;

  ViewTaskPage({required this.task});

  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[600]),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(content),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviceReportProvider =
        Provider.of<ServiceReportProvider>(context, listen: false);

    // Check if a service report exists for this task
    bool reportExists =
        serviceReportProvider.reports.any((report) => report.taskId == task.Id);

    Project? project;
    if (task.projectId != null) {
      final projectProvider =
          Provider.of<ProjectProvider>(context, listen: false);
      project = projectProvider.getProjectById(task.projectId!);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'View Task',
          style: headingTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
                Icons.assignment, "Task Type", task.taskType ?? 'No Task Type'),
            _buildDivider(),
            _buildInfoRow(Icons.business, "Project Name",
                project?.projectName ?? 'No Project Name'),
            _buildDivider(),
            _buildInfoRow(Icons.person, "Customer",
                task.customer?.company ?? 'No Customer'),
            _buildDivider(),
            _buildInfoRow(Icons.person_outline, "Contact Person",
                task.contactPerson ?? 'No Contact Person'),
            _buildDivider(),
            _buildInfoRow(Icons.phone, "Contact Number",
                task.contactNumber ?? 'No Contact Number'),
            _buildDivider(),
            _buildInfoRow(
                Icons.branding_watermark, "Brand", task.brand ?? 'No Brand'),
            _buildDivider(),
            _buildInfoRow(
                Icons.model_training, "Model", task.model ?? 'No Model'),
            _buildDivider(),
            _buildInfoRow(Icons.confirmation_number, "Serial Number",
                task.serial ?? 'No Serial Number'),
            _buildDivider(),
            _buildInfoRow(Icons.calendar_today, "Date",
                DateFormat.yMd().format(task.date ?? DateTime.now())),
            _buildDivider(),
            _buildInfoRow(
                Icons.group, "Assignee", task.serviceteam ?? 'No Assignee'),
            _buildDivider(),
            _buildInfoRow(Icons.note, "Note", task.note ?? 'No Note'),
            _buildDivider(),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (reportExists) {
                        // Navigate to ServiceReportHistory if a report exists
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ServiceReportDetailPage(
                              serviceReport: serviceReportProvider.reports
                                  .firstWhere(
                                      (report) => report.taskId == task.Id),
                            ),
                          ),
                        );
                      } else {
                        // Navigate to ServiceReportPage to create a new report
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ServiceReportPage(task: task),
                          ),
                        );
                      }
                    },
                    child: Text(reportExists
                        ? 'View Service Report History'
                        : 'Create Service Report'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Theme.of(context).colorScheme.secondary, // Text color
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Good Issues'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Theme.of(context).colorScheme.secondary, // Text color
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Divider _buildDivider() => Divider(height: 30, thickness: 1);
}
