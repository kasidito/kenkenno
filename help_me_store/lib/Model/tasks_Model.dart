import 'dart:math';

import 'package:flutter/material.dart';
import 'package:help_me_store/Model/customers_Model.dart';
import 'package:help_me_store/Model/projects_Model.dart';
import 'package:help_me_store/Model/tasks_Model.dart';
import 'package:help_me_store/Model/employees_Model.dart';
import 'package:uuid/uuid.dart';

class Task {
  String Id;
  String? projectId; // Reference to Project ID
  Customers? customer;
  String? contactPerson;
  String? contactNumber;
  String? taskType;
  DateTime? date;
  String? brand;
  String? model;
  String? serial;
  String? note;
  String? serviceteam;
  TaskStatus status;
  String? assignedEmployeeId = '';

  Task({
    required this.Id,
    this.projectId,
    this.customer,
    this.contactPerson,
    this.contactNumber,
    this.taskType,
    this.date,
    this.brand,
    this.model,
    this.serial,
    this.note,
    this.serviceteam,
    this.status = TaskStatus.assigned,
    this.assignedEmployeeId,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'Id': Id,
  //     'projectId': projectId,
  //     // 'projectName': projectName?.toMap(), // If you need to store the entire project object
  //     'customer':
  //         customer?.toMap(), // Convert customer to a map or just store an ID
  //     'contactPerson': contactPerson,
  //     'contactNumber': contactNumber,
  //     'taskType': taskType,
  //     'date': date?.toIso8601String(),
  //     'brand': brand,
  //     'model': model,
  //     'serial': serial,
  //     'note': note,
  //     'serviceteam': serviceteam,
  //     'status': status.toString(),
  //     'assignedEmployeeId': assignedEmployeeId,
  //   };
  // }

  // factory Task.fromMap(Map<String, dynamic> map) {
  //   return Task(
  //     Id: map['Id'],
  //     projectId: map['projectId'],
  //     // projectName: Project.fromMap(map['projectName']), // If you're storing the entire project object
  //     customer: Customers.fromMap(map['customer']),
  //     contactPerson: map['contactPerson'],
  //     contactNumber: map['contactNumber'],
  //     taskType: map['taskType'],
  //     date: map['date'] != null ? DateTime.parse(map['date']) : null,
  //     brand: map['brand'],
  //     model: map['model'],
  //     serial: map['serial'],
  //     note: map['note'],
  //     serviceteam: map['serviceteam'],
  //     status: TaskStatus.values.firstWhere(
  //       (e) => e.toString() == 'TaskStatus.' + map['status'],
  //       orElse: () => TaskStatus.assigned, // Default value
  //     ),
  //     assignedEmployeeId: map['assignedEmployeeId'],
  //   );
  // }
}

enum TaskStatus { assigned, accepted, finished }

List<String> taskTypes = [
  'Installation',
  'Start up',
  'Repair',
  'Inspection',
  'Delivery Product',
  'Training',
  'Delivery Document',
  'Claim',
  'Design',
];

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [...mockTasks()];
  var uuid = Uuid();
  List<Task> get tasks => _tasks;
  String employeeId = 'getCurrentLoggedInUserId()';

  List<Task> getTasksByProjectId(String projectId) {
    return _tasks.where((task) => task.projectId == projectId).toList();
    print('Get Tasks By Project ID: $projectId');
  }

  List<Task> getTasksByEmployeeId(String employeeId) {
    return _tasks
        .where((task) => task.assignedEmployeeId == employeeId)
        .toList();
    print('Get Tasks By Employee ID: $employeeId');
  }

  void loadTasks() {
    _tasks = [...mockTasks()];
    notifyListeners();
    print('Load Tasks');
  }

  void addOrUpdateTask(Task task) {
    final existingTaskIndex = _tasks.indexWhere((t) => t.Id == task.Id);
    if (existingTaskIndex != -1) {
      _tasks[existingTaskIndex] = task;
      print('Update Task: $existingTaskIndex');
    } else {
      task.Id = uuid.v4();
      _tasks.add(task);
      print('Add Task: $task');
    }
    notifyListeners();
  }

  void removeTask(String taskId) {
    _tasks.removeWhere((t) => t.Id == taskId);
    print('Remove Task: $taskId');
    notifyListeners();
  }

  void updateTaskStatus(String taskId, TaskStatus newStatus) {
    int index = _tasks.indexWhere((task) => task.Id == taskId);
    if (index != -1) {
      _tasks[index].status = newStatus;
      print('Update Task Status: $taskId');
      notifyListeners();
    }
  }

  void updateTaskServiceTeam(String taskId, String? serviceTeam) {
    final taskIndex = _tasks.indexWhere((t) => t.Id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex].serviceteam = serviceTeam;
      print('Update Task Service Team: $taskId');
      notifyListeners();
    } else {
      print('Task not found');
    }
  }

  List<Task> getUnassignedTasks() {
    return _tasks.where((task) => task.assignedEmployeeId == '').toList();
    print('Get Unassigned Tasks');
  }
}

List<Task> mockTasks() {
  var uuid = Uuid();

  List<Project> projects = mockProjects();
  List<Employee> employees = mockEmployees();

  // Mock Tasks
  return [
    // Tasks for the first project
    Task(
      Id: uuid.v4(),
      projectId: projects[0].Id, // Assign to the first project
      taskType: "Design",
      date: DateTime(2023, 1, 11),
      status: TaskStatus.assigned,
      customer: projects[0].customer,
      contactPerson: projects[0].contactPerson,
      contactNumber: projects[0].contactNumber,
      brand: "Brand A",
      model: "Model A",
      serial: "12345",
      serviceteam: mockEmployees()[0].firstName +
          " " +
          mockEmployees()[0].lastName +
          ", " +
          mockEmployees()[0].nickName,
      note: "Discuss with the customer about the design.",
      assignedEmployeeId: employees[0].Id,
    ),
    Task(
      Id: uuid.v4(),
      projectId: projects[0].Id, // Assign to the first project
      taskType: "Installation",
      date: DateTime(2023, 1, 15),
      status: TaskStatus.assigned,
      customer: projects[0].customer,
      contactPerson: projects[0].contactPerson,
      contactNumber: projects[0].contactNumber,
      brand: "Brand A",
      model: "Model A",
      serial: "12345",
      serviceteam: mockEmployees()[1].firstName +
          " " +
          mockEmployees()[1].lastName +
          ", " +
          mockEmployees()[1].nickName,
      note: "Please bring the necessary tools for the installation.",
      assignedEmployeeId: employees[1].Id,
    ),

    // Tasks for the second project
    Task(
      Id: uuid.v4(),
      projectId: projects[1].Id, // Assign to the second project
      taskType: "Inspection",
      date: DateTime(2023, 3, 16),
      status: TaskStatus.assigned,
      customer: projects[1].customer,
      contactPerson: projects[1].contactPerson,
      contactNumber: projects[1].contactNumber,
      brand: "Brand B",
      model: "Model B",
      serial: "12345",
      serviceteam: mockEmployees()[2].firstName +
          " " +
          mockEmployees()[2].lastName +
          ", " +
          mockEmployees()[2].nickName,
      note: "Discuss with the customer about the maintenance plan.",
      assignedEmployeeId: employees[2].Id,
    ),
    Task(
      Id: uuid.v4(),
      projectId: projects[1].Id, // Assign to the second project
      taskType: "Repair",
      date: DateTime(2023, 3, 18),
      status: TaskStatus.assigned,
      customer: projects[1].customer,
      contactPerson: projects[1].contactPerson,
      contactNumber: projects[1].contactNumber,
      brand: "Brand B",
      model: "Model B",
      serial: "12345",
      serviceteam: mockEmployees()[3].firstName +
          " " +
          mockEmployees()[3].lastName +
          ", " +
          mockEmployees()[3].nickName,
      note: "Prepare air filter and oil filter for the maintenance.",
      assignedEmployeeId: employees[3].Id,
    ),

    // Tasks for the third project
    Task(
      Id: uuid.v4(),
      projectId: projects[2].Id, // Assign to the third project
      taskType: "Inspection",
      date: DateTime(2023, 5, 21),
      status: TaskStatus.assigned,
      customer: projects[2].customer,
      contactPerson: projects[2].contactPerson,
      contactNumber: projects[2].contactNumber,
      brand: "Brand C",
      model: "Model C",
      serial: "12345",
      serviceteam: mockEmployees()[4].firstName +
          " " +
          mockEmployees()[4].lastName +
          ", " +
          mockEmployees()[4].nickName,
      note: "Discuss with the customer about renting a spare air compressor.",
    ),
    Task(
      Id: uuid.v4(),
      projectId: projects[2].Id, // Assign to the third project
      taskType: "Start up",
      date: DateTime(2023, 6, 10),
      status: TaskStatus.assigned,
      customer: projects[2].customer,
      contactPerson: projects[2].contactPerson,
      contactNumber: projects[2].contactNumber,
      brand: "Brand C",
      model: "Model C",
      serial: "12345",
      serviceteam: mockEmployees()[5].firstName +
          " " +
          mockEmployees()[5].lastName +
          ", " +
          mockEmployees()[5].nickName,
      note:
          "Please bring the necessary tools for the start up and some spare parts.",
    ),
    // ... Add more tasks as needed ...
  ];
}
