import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasidit_final_app/models/schedules_Model.dart';

class ScheduleService {
  Future<List<Schedule>> fetchSchedules() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('kasidit_schedules')
          .get();

      print("Schedules in firebase count:${snapshot.docs.length}");

      return snapshot.docs.map((doc) => Schedule.fromSnapshot(doc)).toList();
    } catch (e) {
      print("Error fetching schedules: $e");
      throw e; // rethrow the error for the controller to handle
    }
  }

  Future<Schedule> addSchedule(Map<String, dynamic> newScheduleData) async {
    try {
      newScheduleData['timestamp'] = FieldValue.serverTimestamp();
      DocumentReference ref = await FirebaseFirestore.instance
          .collection('kasidit_schedules')
          .add(newScheduleData);

      // Fetch the newly added document
      DocumentSnapshot newDoc = await ref.get();
      return Schedule.fromSnapshot(newDoc);
    } catch (e) {
      print("Error adding schedule: $e");
      throw e; // rethrow the error for the controller to handle
    }
  }

  Future<Schedule> updateSchedule(
      String scheduleId, Map<String, dynamic> updatedScheduleData) async {
    updatedScheduleData['timestamp'] = FieldValue.serverTimestamp();
    try {
      DocumentReference scheduleRef = FirebaseFirestore.instance
          .collection('kasidit_schedules')
          .doc(scheduleId);

      // Update the document
      await scheduleRef.update(updatedScheduleData);

      // Fetch the updated document
      DocumentSnapshot updatedDoc = await scheduleRef.get();
      return Schedule.fromSnapshot(updatedDoc);
    } catch (e) {
      print("Error updating schedule: $e");
      throw e;
    }
  }

  Future<void> deleteSchedule(String scheduleId) async {
    try {
      await FirebaseFirestore.instance
          .collection('kasidit_schedules')
          .doc(scheduleId)
          .delete();
    } catch (e) {
      print("Error deleting schedule: $e");
      throw e; // rethrow the error for the controller to handle
    }
  }
}
