// import 'package:flutter/material.dart';
// import 'package:help_me_store/Model/projects_Model.dart';
// import 'package:help_me_store/Model/serviceReport_Model.dart';
// import 'package:help_me_store/Model/tasks_Model.dart';

// import 'package:uuid/uuid.dart';

// class ServiceReportProvider with ChangeNotifier {
//   List<ServiceReport> _reports = [];
//   var uuid = Uuid();

//   List<ServiceReport> get projects => _reports;

//   void addReport(ServiceReport serviceReport) {
//     serviceReport.Id = uuid.v4();
//     _reports.add(serviceReport);
//     notifyListeners();
//   }

//   void updateReport(ServiceReport updatedReport) {
//     int index = _reports
//         .indexWhere((serviceReport) => serviceReport.Id == updatedReport.Id);
//     if (index != -1) {
//       _reports[index] = updatedReport;
//       notifyListeners();
//     }
//   }

//   void removeReport(ServiceReport serviceReport) {
//     _reports.removeWhere((p) => p.Id == serviceReport.Id);
//     notifyListeners();
//   }

//   void addReportToTask(String taskId, ServiceReport serviceReport) {
//     int taskIndex = _reports.indexWhere((task) => task.Id == taskId);
//     if (taskIndex != -1) {
//       _reports[taskIndex].serviceReports.add(serviceReport);
//       notifyListeners();
//     }
//   }
// }
