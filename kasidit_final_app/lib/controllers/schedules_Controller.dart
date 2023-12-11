import 'dart:async';

import 'package:kasidit_final_app/models/schedules_Model.dart';
import 'package:kasidit_final_app/services/schedules_Service.dart';

class ScheduleController {
  final ScheduleService _scheduleService = ScheduleService();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  Future<List<Schedule>> fetchSchedules() async {
    print('fetchSchedules is called');

    onSyncController.add(true);
    await Future.delayed(Duration(seconds: 2)); // 2-second delay

    try {
      List<Schedule> schedules = await _scheduleService.fetchSchedules();
      print(schedules);
      onSyncController.add(false);
      return schedules;
    } catch (e) {
      onSyncController.add(false);
      throw e;
    }
  }

  Future<Schedule?> addSchedule(Map<String, dynamic> newScheduleData) async {
    print('addSchedule is called');
    onSyncController.add(true);
    try {
      Schedule addedSchedule =
          await _scheduleService.addSchedule(newScheduleData);
      print(addedSchedule);
      onSyncController.add(false);
      return addedSchedule;
    } catch (e) {
      print("Error adding schedule: $e");
      onSyncController.add(false);
      return null;
    }
  }

  Future<Schedule?> updateSchedule(
      String scheduleId, Map<String, dynamic> updatedScheduleData) async {
    print('updateSchedule is called');
    onSyncController.add(true);
    try {
      Schedule updatedSchedule = await _scheduleService.updateSchedule(
          scheduleId, updatedScheduleData);
      print(updatedSchedule);
      onSyncController.add(false);
      return updatedSchedule;
    } catch (e) {
      print("Error updating schedule: $e");
      onSyncController.add(false);
      return null;
    }
  }

  Future<void> deleteSchedule(String scheduleId) async {
    print('deleteSchedule is called');
    onSyncController.add(true);
    try {
      await _scheduleService.deleteSchedule(scheduleId);
      onSyncController.add(false);
    } catch (e) {
      print("Error deleting schedule: $e");
      onSyncController.add(false);
    }
  }
}
