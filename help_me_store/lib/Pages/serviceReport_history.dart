import 'package:flutter/material.dart';
import 'package:help_me_store/Model/serviceReport_Model.dart';
import 'package:help_me_store/Widgets/font.dart';
import 'package:provider/provider.dart';
import 'serviceReport_detail.dart'; // Make sure to import the detail page

class ServiceReportHistory extends StatelessWidget {
  ServiceReportHistory();

  @override
  Widget build(BuildContext context) {
    List<ServiceReport> reports =
        Provider.of<ServiceReportProvider>(context).reports;

    if (reports.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Service Report History'),
        ),
        body: Center(child: Text('No reports available')),
      );
    }

    // If reports are available, build the ListView
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Service Report History'),
      ),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          ServiceReport report = reports[index];
          return InkWell(
            onTap: () {
              print('Tapped on ${report.Id}');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ServiceReportDetailPage(serviceReport: report),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(12.0),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Project Name: ${report.projectName}',
                        style: titleTextStle),
                    SizedBox(height: 8),
                    Text('Task Type: ${report.taskType}',
                        style: subTitleTextStle),
                    SizedBox(height: 8),
                    Text('Service Name: ${report.serviceName}',
                        style: bodyTextStyle),
                    SizedBox(height: 8),
                    Text(
                      'Date: ${report.serviceDate.day}/${report.serviceDate.month}/${report.serviceDate.year}',
                      style: bodyTextStyle,
                    ),

                    // ... Add more details as needed ...
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
