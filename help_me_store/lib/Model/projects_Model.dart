import 'package:help_me_store/Model/customers_Model.dart';
import 'package:help_me_store/Model/tasks_Model.dart';
import 'package:help_me_store/Pages/project_Sales.dart';
import 'package:flutter/material.dart';
// import 'package:help_me_store/Pages/project_Service.dart';
import 'package:help_me_store/Model/tasks_Model.dart';

import 'package:uuid/uuid.dart';

// Add other project-specific fields if needed
class Project {
  String Id;
  String projectName; // Removed 'final' keyword
  String? projectType;
  DateTime? startDate;
  DateTime? endDate;
  DateTime timeStamp = DateTime.now();
  String? projectDetails;
  Customers customer;
  String contactPerson;
  String contactNumber;
  ProjectStatus status;
  List<String> taskIds;

  Project({
    required this.Id,
    required this.projectName,
    this.projectType,
    this.startDate,
    this.endDate,
    required this.timeStamp,
    this.projectDetails = "",
    required this.customer,
    this.contactPerson = "",
    this.contactNumber = "",
    this.status = ProjectStatus.planning,
    this.taskIds = const [],
  });

  // Convert a Project instance to a Map. Useful for encoding to JSON or saving to a database.
  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'projectName': projectName,
      'projectType': projectType,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'timeStamp': timeStamp.toIso8601String(),
      'projectDetails': projectDetails,
      'customer': customer.toMap(),
      'contactPerson': contactPerson,
      'contactNumber': contactNumber,
      'status': status.toString(),
      'taskIds': taskIds,
    };
  }

  // Create a Project from a Map. Useful for decoding from JSON or a database.
  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      Id: map['Id'],
      projectName: map['projectName'],
      projectType: map['projectType'],
      startDate:
          map['startDate'] != null ? DateTime.parse(map['startDate']) : null,
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      timeStamp: DateTime.parse(map['timeStamp']),
      projectDetails: map['projectDetails'],
      customer: Customers.fromMap(map['customer']),
      contactPerson: map['contactPerson'],
      contactNumber: map['contactNumber'],
      status: ProjectStatus.values.firstWhere(
        (e) => e.toString() == 'ProjectStatus.' + map['status'],
        orElse: () => ProjectStatus.planning, // Default value
      ),
      taskIds: List<String>.from(map['taskIds']),
    );
  }
}

enum ProjectStatus {
  planning,
  inProgress,
  completed
  // Add other statuses as needed
}

List<String> projectTypes = [
  'Preventive Maintenance',
  'Installation',
  'Overhaul',
  // Add other types as needed
];

class ProjectProvider with ChangeNotifier {
  List<Project> _projects = [...mockProjects()];
  final Uuid uuid = Uuid();

  List<Project> get projects => _projects;

  void addProject(Project project) {
    project.Id = uuid.v4();
    _projects.add(project);
    print('Add Project: $project');
    notifyListeners();
  }

  void updateProject(Project updatedProject) {
    int index =
        _projects.indexWhere((project) => project.Id == updatedProject.Id);
    if (index != -1) {
      _projects[index] = updatedProject;
      print('Update Project: $updatedProject');
      notifyListeners();
    }
  }

  void removeProject(Project project) {
    _projects.removeWhere((p) => p.Id == project.Id);
    print('Remove Project: $project');
    notifyListeners();
  }

  void updateProjectStatus(String projectId, ProjectStatus newStatus) {
    int index = _projects.indexWhere((project) => project.Id == projectId);
    if (index != -1) {
      _projects[index].status = newStatus;
      print('Update Project Status: $projectId');
      notifyListeners();
    } else {
      // Handle the case where the project is not found
    }
  }

  Project? getProjectById(String projectId) {
    return _projects.firstWhere((project) => project.Id == projectId);
    print('Get Project By ID: $projectId');
  }

  void addTaskToProject(String projectId, String taskId) {
    final projectIndex = _projects.indexWhere((p) => p.Id == projectId);
    if (projectIndex != -1) {
      _projects[projectIndex].taskIds.add(taskId);
      print('Add Task to Project: $projectId');
      notifyListeners();
    }
  }

  void removeTaskFromProject(String projectId, String taskId) {
    final projectIndex = _projects.indexWhere((p) => p.Id == projectId);
    if (projectIndex != -1) {
      _projects[projectIndex].taskIds.remove(taskId);
      print('Remove Task from Project: $projectId');
      notifyListeners();
    }
  }

  void updateTaskInProject(String projectId, String oldTaskId, Task newTask) {
    final projectIndex = _projects.indexWhere((p) => p.Id == projectId);
    if (projectIndex != -1) {
      final taskIndex =
          _projects[projectIndex].taskIds.indexWhere((id) => id == oldTaskId);
      if (taskIndex != -1) {
        _projects[projectIndex].taskIds[taskIndex] = newTask.Id;
        print('Update Task in Project: $projectId');
        // Update task logic here
        notifyListeners();
      }
    }
  }
}

List<Project> mockProjects() {
  var uuid = Uuid();

  // Using provided Customers
  var customer1 = companies[0]; // ABC manufacturing Co., Ltd.
  var customer2 = companies[2]; // ConstructMat Co., Ltd.
  var customer3 = companies[4]; // Plasmatic Co., Ltd.

  // Mock Projects
  return [
    Project(
      Id: uuid.v4(),
      projectName: "Air Compressor Installation",
      projectType: "Installation",
      startDate: DateTime(2023, 1, 10),
      endDate: DateTime(2023, 2, 10),
      timeStamp: DateTime.now(),
      projectDetails:
          "Installation of new air compressor systems at ABC manufacturing.",
      customer: customer1,
      contactPerson: customer1.contactPerson ?? '', // Corrected
      contactNumber: customer1.contactNumber ?? '', // Corrected
      status: ProjectStatus.inProgress,
      taskIds: [],
    ),
    Project(
      Id: uuid.v4(),
      projectName: "Routine Maintenance",
      projectType: "Preventive Maintenance",
      startDate: DateTime(2023, 3, 15),
      endDate: DateTime(2023, 4, 15),
      timeStamp: DateTime.now(),
      projectDetails: "Quarterly preventive maintenance at ConstructMat.",
      customer: customer2,
      contactPerson: customer2.contactPerson ?? '', // Corrected
      contactNumber: customer2.contactNumber ?? '', // Corrected
      status: ProjectStatus.planning,
      taskIds: [],
    ),
    Project(
      Id: uuid.v4(),
      projectName: "System Overhaul",
      projectType: "Overhaul",
      startDate: DateTime(2023, 5, 20),
      endDate: DateTime(2023, 7, 20),
      timeStamp: DateTime.now(),
      projectDetails:
          "Complete overhaul of air compressor systems at Plasmatic.",
      customer: customer3,
      contactPerson: customer3.contactPerson ?? '', // Corrected
      contactNumber: customer3.contactNumber ?? '', // Corrected
      status: ProjectStatus.completed,
      taskIds: [],
    ),
  ];
}
