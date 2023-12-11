import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Schedule {
  String Id;
  String movieId;
  String movieTitle;
  String movieimagePath;
  Timestamp timeStamp;
  Timestamp scheduleTime;
  String userId;

  Schedule(
    this.Id,
    this.movieId,
    this.movieTitle,
    this.movieimagePath,
    this.timeStamp,
    this.scheduleTime,
    this.userId,
  );

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      json['Id'] as String,
      json['movieId'] as String,
      json['movieTitle'] as String,
      json['movieimagePath'] as String,
      json['timeStamp'] as Timestamp,
      json['scheduleTime'] as Timestamp,
      json['userId'] as String,
    );
  }

  factory Schedule.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    return Schedule(
      snapshot.id,
      json['movieId'] as String,
      json['movieTitle'] as String,
      json['movieimagePath'] as String,
      json['timeStamp'] as Timestamp,
      json['scheduleTime'] as Timestamp,
      json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'movieId': movieId,
      'movieTitle': movieTitle,
      'movieimagePath': movieimagePath,
      'timeStamp': FieldValue.serverTimestamp(),
      'scheduleTime': scheduleTime,
      'userId': userId,
    };
  }

  String toString() {
    return 'Schedule{Id: $Id, movieId: $movieId,movieTitle: $movieTitle, movieimagePath: $movieimagePath, timestamp: $timeStamp, scheduleTime: $scheduleTime, userId: $userId}';
  }
}

class AllSchedules {
  final List<Schedule> schedules;

  AllSchedules(this.schedules);

  factory AllSchedules.fromJson(List<dynamic> json) {
    List<Schedule> schedules =
        json.map((item) => Schedule.fromJson(item)).toList();
    return AllSchedules(schedules);
  }

  factory AllSchedules.fromSnapshot(QuerySnapshot qs) {
    List<Schedule> schedules = qs.docs.map((DocumentSnapshot ds) {
      Map<String, dynamic> dataWithId = ds.data() as Map<String, dynamic>;
      dataWithId['id'] = ds.id;
      return Schedule.fromJson(dataWithId);
    }).toList();
    return AllSchedules(schedules);
  }

  Map<String, dynamic> toJson() {
    return {
      'schedules': schedules.map((schedule) => schedule.toJson()).toList(),
    };
  }
}

class SchedulesProvider extends ChangeNotifier {
  List<Schedule>? _allSchedules = [];

  List<Schedule>? get allSchedules => _allSchedules;

  void setSchedules(List<Schedule>? schedules) {
    _allSchedules = schedules;
    notifyListeners();
  }

  void addSchedule(Schedule schedule) {
    print("addSchedule @ provider is called");
    _allSchedules!.add(schedule);
    notifyListeners();
  }

  void updateSchedule(Schedule updatedSchedule) {
    print("updateSchedule @ provider is called");
    int index = _allSchedules!
        .indexWhere((schedule) => schedule.Id == updatedSchedule.Id);
    if (index != -1) {
      _allSchedules![index] = updatedSchedule;
      notifyListeners();
    }
  }

  void deleteSchedule(String scheduleId) {
    print("deleteSchedule @ provider is called");
    int index =
        _allSchedules!.indexWhere((schedule) => schedule.Id == scheduleId);
    if (index != -1) {
      _allSchedules!.removeAt(index);
      notifyListeners();
    }
  }
}
