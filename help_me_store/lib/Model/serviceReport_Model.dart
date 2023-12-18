import 'dart:math';

import 'package:help_me_store/Model/employees_Model.dart';
import 'package:help_me_store/Model/projects_Model.dart';
import 'package:flutter/material.dart';
import 'package:help_me_store/Model/projects_Model.dart';
import 'package:help_me_store/Model/serviceReport_Model.dart';
import 'package:help_me_store/Model/tasks_Model.dart';

import 'package:uuid/uuid.dart';

enum ServiceReportStatus { Task, Ticket }

class ServiceReport {
  //Header
  String Id;
  String? taskId;
  // String? ticketId;
  String? brand;
  String? model;
  String? serial;
  String? projectName;
  String? taskType;
  DateTime serviceDate;
  TimeOfDay? serviceTime;
  DateTime timeStamp = DateTime.now();
  String? serviceName;
  ServiceReportStatus? status;
  String? attachedFileName;
  //Detail
  num? ambientTemp;
  num? sumpPressLoad;
  num? sumpPressUnLoad;
  num? dischPressLoad;
  num? dischPressUnLoad;
  num? airEndDischTemp;
  num? airDischTemp;
  num? firstDischPressTwoStage;
  num? pressureDrop;
  String? airFilterPN;
  num? airFilterHr;
  bool? airFilterCR;
  String? oilFilterPN;
  num? oilFilterHr;
  bool? oilFilterCR;
  String? separatorPN;
  num? separatorHr;
  bool? separatorCR;
  String? lubricantPN;
  num? lubricantHr;
  bool? lubricantCR;
  String? inletValvePN;
  num? inletValveHr;
  bool? inletValveCR;
  num? blowDownHr;
  bool? blowDownCR;
  num? minCheckValveHr;
  bool? minCheckValveCR;
  String? hoses;
  num? hosesHr;
  bool? hosesCR;
  num? waterTemp;
  num? couplingHr;
  bool? couplingCR;
  num? voltageLoad;
  num? voltageUnload;
  num? currentLoad;
  num? currentUnload;
  //bool
  bool? thermostaticValve;
  bool? solenoidValve;
  bool? autoDrain;
  bool? tempSensor;
  bool? pressureSensor;
  bool? mainMotor;
  bool? fanMotor;
  bool? magneticContactor;
  bool? scavenging;
  bool? boardControl;
  bool? emergencyStop;
  bool? cooler;
  bool? sound;
  String? problem;
  String? recommend;

  ServiceReport({
    //Header
    required this.Id,
    this.taskId,
    // this.ticketId,
    this.brand,
    this.model,
    this.serial,
    this.projectName,
    this.taskType,
    required this.serviceDate,
    this.serviceTime,
    required this.timeStamp,
    this.serviceName,
    this.status,
    this.attachedFileName,
    //Details
    this.ambientTemp,
    this.sumpPressLoad,
    this.sumpPressUnLoad,
    this.dischPressLoad,
    this.dischPressUnLoad,
    this.airEndDischTemp,
    this.airDischTemp,
    this.firstDischPressTwoStage,
    this.pressureDrop,
    this.airFilterPN,
    this.airFilterHr,
    this.airFilterCR,
    this.oilFilterPN,
    this.oilFilterHr,
    this.oilFilterCR,
    this.separatorPN,
    this.separatorHr,
    this.separatorCR,
    this.lubricantPN,
    this.lubricantHr,
    this.lubricantCR,
    this.inletValvePN,
    this.inletValveHr,
    this.inletValveCR,
    this.blowDownHr,
    this.blowDownCR,
    this.minCheckValveHr,
    this.minCheckValveCR,
    this.hoses,
    this.hosesHr,
    this.hosesCR,
    this.waterTemp,
    this.couplingHr,
    this.couplingCR,
    this.voltageLoad,
    this.voltageUnload,
    this.currentLoad,
    this.currentUnload,
    //bool
    this.thermostaticValve = true,
    this.solenoidValve = true,
    this.autoDrain = true,
    this.tempSensor = true,
    this.pressureSensor = true,
    this.mainMotor = true,
    this.fanMotor = true,
    this.magneticContactor = true,
    this.scavenging = true,
    this.boardControl = true,
    this.emergencyStop = true,
    this.sound = true,
    //string
    this.problem,
    this.recommend,
  });

  get serviceReports => [];
}

class ServiceReportProvider with ChangeNotifier {
  List<ServiceReport> _reports = [...mockreports];
  var uuid = Uuid();

  List<ServiceReport> get reports => _reports;

  void addReport(ServiceReport serviceReport) {
    serviceReport.Id = uuid.v4();
    _reports.add(serviceReport);
    print('Add Report: $serviceReport');
    notifyListeners();
  }

  void updateReport(ServiceReport updatedReport) {
    int index = _reports
        .indexWhere((serviceReport) => serviceReport.Id == updatedReport.Id);
    if (index != -1) {
      _reports[index] = updatedReport;
      print('Update Report: $updatedReport');
      notifyListeners();
    }
  }

  void removeReport(ServiceReport serviceReport) {
    _reports.removeWhere((p) => p.Id == serviceReport.Id);
    print('Remove Report: $serviceReport');
    notifyListeners();
  }

  void addReportToTask(String taskId, ServiceReport serviceReport) {
    int taskIndex = _reports.indexWhere((task) => task.Id == taskId);
    if (taskIndex != -1) {
      _reports[taskIndex].serviceReports.add(serviceReport);
      print('Add Report to Task: $taskId');
      notifyListeners();
    }
  }

  List<ServiceReport> getServiceReportsForTask(String taskId) {
    return _reports.where((report) => report.taskId == taskId).toList();
    print('Get Service Reports for Task: $taskId');
  }
}

List<ServiceReport> mockreports = [
  ServiceReport(
    Id: "uuid1",
    projectName: "Project Alpha",
    taskType: "Maintenance",
    serviceDate: DateTime(2023, 9, 15),
    serviceTime: TimeOfDay(hour: 10, minute: 30),
    timeStamp: DateTime.now(),
    brand: "BrandX",
    model: "ModelA",
    serial: "12345",
    serviceName: "Specialist A",
    ambientTemp: 25,
    sumpPressLoad: 10,
    sumpPressUnLoad: 3,
    dischPressLoad: 8,
    dischPressUnLoad: 2,
    airEndDischTemp: 60,
    airDischTemp: 55,
    firstDischPressTwoStage: 12,
    pressureDrop: 1,
    airFilterPN: "AF123",
    airFilterHr: 100,
    airFilterCR: true,
    oilFilterPN: "OF123",
    oilFilterHr: 150,
    oilFilterCR: false,
    separatorPN: "SP123",
    separatorHr: 200,
    separatorCR: true,
    lubricantPN: "LP123",
    lubricantHr: 250,
    lubricantCR: false,
    inletValvePN: "IV123",
    inletValveHr: 300,
    inletValveCR: true,
    blowDownHr: 350,
    blowDownCR: false,
    minCheckValveHr: 400,
    minCheckValveCR: true,
    hoses: "Good Condition",
    hosesHr: 450,
    hosesCR: true,
    waterTemp: 30,
    couplingHr: 500,
    couplingCR: false,
    voltageLoad: 220,
    voltageUnload: 110,
    currentLoad: 15,
    currentUnload: 7,
    thermostaticValve: true,
    solenoidValve: false,
    autoDrain: true,
    tempSensor: true,
    pressureSensor: false,
    mainMotor: true,
    fanMotor: false,
    magneticContactor: true,
    scavenging: false,
    boardControl: true,
    emergencyStop: false,
    sound: true,
    problem: "Minor leakage detected",
    recommend: "Tighten the joints and recheck",
  ),
  ServiceReport(
    Id: "uuid2",
    projectName: "Project Beta",
    taskType: "Repair",
    serviceDate: DateTime(2023, 10, 20),
    serviceTime: TimeOfDay(hour: 14, minute: 45),
    timeStamp: DateTime.now(),
    brand: "BrandY",
    model: "ModelB",
    serial: "67890",
    serviceName: "Specialist B",
    ambientTemp: 30,
    sumpPressLoad: 12,
    sumpPressUnLoad: 4,
    dischPressLoad: 10,
    dischPressUnLoad: 3,
    airEndDischTemp: 65,
    airDischTemp: 60,
    firstDischPressTwoStage: 14,
    pressureDrop: 2,
    airFilterPN: "AF456",
    airFilterHr: 200,
    airFilterCR: true,
    oilFilterPN: "OF456",
    oilFilterHr: 250,
    oilFilterCR: false,
    separatorPN: "SP456",
    separatorHr: 300,
    separatorCR: true,
    lubricantPN: "LP456",
    lubricantHr: 350,
    lubricantCR: false,
    inletValvePN: "IV456",
    inletValveHr: 400,
    inletValveCR: true,
    blowDownHr: 450,
    blowDownCR: false,
    minCheckValveHr: 500,
    minCheckValveCR: true,
    hoses: "Good Condition",
    hosesHr: 550,
    hosesCR: false,
    waterTemp: 35,
    couplingHr: 600,
    couplingCR: true,
    voltageLoad: 220,
    voltageUnload: 110,
    currentLoad: 15,
    currentUnload: 7,
    thermostaticValve: true,
    solenoidValve: false,
    autoDrain: true,
    tempSensor: true,
    pressureSensor: false,
    mainMotor: true,
    fanMotor: false,
    magneticContactor: true,
    scavenging: false,
    boardControl: true,
    emergencyStop: false,
    sound: true,
    problem: "Overheating issue",
    recommend: "Check and replace the cooling system",
  ),
  ServiceReport(
    Id: "uuid3",
    projectName: "Project Gamma",
    taskType: "Inspection",
    serviceDate: DateTime(2023, 11, 5),
    serviceTime: TimeOfDay(hour: 9, minute: 15),
    timeStamp: DateTime.now(),
    brand: "BrandZ",
    model: "ModelC",
    serial: "54321",
    serviceName: "Specialist C",
    ambientTemp: 20,
    sumpPressLoad: 8,
    sumpPressUnLoad: 2,
    dischPressLoad: 6,
    dischPressUnLoad: 1,
    airEndDischTemp: 55,
    airDischTemp: 50,
    firstDischPressTwoStage: 10,
    pressureDrop: 0.5,
    airFilterPN: "AF789",
    airFilterHr: 300,
    airFilterCR: true,
    oilFilterPN: "OF789",
    oilFilterHr: 350,
    oilFilterCR: false,
    separatorPN: "SP789",
    separatorHr: 400,
    separatorCR: true,
    lubricantPN: "LP789",
    lubricantHr: 450,
    lubricantCR: false,
    inletValvePN: "IV789",
    inletValveHr: 500,
    inletValveCR: true,
    blowDownHr: 550,
    blowDownCR: false,
    minCheckValveHr: 600,
    minCheckValveCR: true,
    hoses: "Good Condition",
    hosesHr: 650,
    hosesCR: false,
    waterTemp: 25,
    couplingHr: 700,
    couplingCR: true,
    voltageLoad: 220,
    voltageUnload: 110,
    currentLoad: 15,
    currentUnload: 7,
    thermostaticValve: true,
    solenoidValve: false,
    autoDrain: true,
    tempSensor: true,
    pressureSensor: false,
    mainMotor: true,
    fanMotor: false,
    magneticContactor: true,
    scavenging: false,
    boardControl: true,
    emergencyStop: false,
    sound: true,
    problem: "Noisy operation",
    recommend: "Lubricate and adjust moving parts",
  )
];
