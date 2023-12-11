import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasidit_final_app/controllers/schedules_Controller.dart';
import 'package:kasidit_final_app/models/schedules_Model.dart';
import 'package:kasidit_final_app/pages/moviesList.dart';
import 'package:intl/intl.dart';

class SchedulesListPage extends StatefulWidget {
  @override
  State<SchedulesListPage> createState() => _SchedulesListPageState();
}

class _SchedulesListPageState extends State<SchedulesListPage> {
  final scheduleController = ScheduleController();
  int _selectedIndex = 1;

  void _confirmDeleteSchedule(String scheduleId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this schedule?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Delete"),
              style: TextButton.styleFrom(
                primary: Colors.red, // Text color
              ),
              onPressed: () {
                scheduleController.deleteSchedule(scheduleId);
                setState(() {
                  scheduleController.fetchSchedules();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    scheduleController.fetchSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Center(
          child: Text('Schedule Lists',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center),
        ),
        backgroundColor:
            Colors.deepPurple.shade200, // Customize the app bar color
      ),
      body: FutureBuilder<List<Schedule>>(
        future: scheduleController.fetchSchedules(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No schedules found'));
          }
          var schedules = snapshot.data!;
          return ListView.builder(
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              var schedule = schedules[index];
              DateTime scheduleDateTime = schedule.scheduleTime.toDate();
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(scheduleDateTime);
              String formattedTime =
                  DateFormat('HH:mm').format(scheduleDateTime);
              return Card(
                elevation: 5, // Add shadow to each card
                margin: EdgeInsets.all(8), // Add margin around each card
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: FadeInImage(
                            placeholder:
                                AssetImage('assets/images/placeholder.png'),
                            image: NetworkImage(schedule.movieimagePath),
                            width: 80.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title: ${schedule.movieTitle}',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                              Text('Date: $formattedDate',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                              Text('Time: $formattedTime',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.0),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _confirmDeleteSchedule(schedule.Id);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepPurple,
        color: Colors.deepPurple.shade200,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          print(index);
          setState(() {
            _selectedIndex = index; // Update the selected index
            if (index == 1) {
              scheduleController.fetchSchedules();
            } else if (index == 0) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MoviesListPage(),
                ),
              );
            }
          });
        },
        items: <Widget>[
          Icon(
            Icons.movie,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.schedule,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
