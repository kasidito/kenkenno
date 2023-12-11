import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kasidit_final_app/models/movies_Model.dart';
import 'package:kasidit_final_app/models/schedules_Model.dart';
import 'package:kasidit_final_app/pages/schedule.dart';

class MoviesDetailPage extends StatefulWidget {
  final Movie movie;

  MoviesDetailPage({required this.movie});

  @override
  _MoviesDetailPageState createState() => _MoviesDetailPageState();
}

class _MoviesDetailPageState extends State<MoviesDetailPage> {
  // Define variables for movie details and time slots
  late String movieTitle;
  late String movieGenre;
  late String movieLength;
  late String movieImagePath;
  late String movieSource;

  Timestamp? timeStamp;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  // String? selectedTimeSlot;
  // List<String> timeSlots = [
  //   '10:00 AM',
  //   '2:00 PM',
  //   '4:00 PM',
  //   '6:00 PM',
  //   '8:00 PM',
  //   '10:00 PM',
  // ];

  @override
  void initState() {
    super.initState();
    movieTitle = widget.movie.title;
    movieGenre = widget.movie.genre;
    movieLength = widget.movie.length;
    movieImagePath = widget.movie.imagePath;
    movieSource = widget.movie.source;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // void _selectTimeSlot(String timeSlot) {
  //   setState(() {
  //     selectedTimeSlot = timeSlot;
  //   });
  // }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void _saveSchedule() async {
    if (selectedDate != null && selectedTime != null) {
      DateTime scheduleDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      Timestamp scheduleTimeStamp = Timestamp.fromDate(scheduleDateTime);

      // Check if the schedule already exists
      bool scheduleExists = await _checkScheduleExists(scheduleTimeStamp);
      if (scheduleExists) {
        _showScheduleConflictDialog();
      } else {
        // Save the scheduleTimestamp to Firebase
        FirebaseFirestore.instance.collection('kasidit_schedules').add({
          'movieId': widget.movie.Id,
          'timeStamp': Timestamp.now(),
          'scheduleTime': scheduleTimeStamp,
          'userId': 'UserId',
          'movieTitle': widget.movie.title,
          'movieimagePath': widget.movie.imagePath,
        });

        print('Schedule saved: $scheduleDateTime');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SchedulesListPage(),
          ),
        );
      }
    } else {
      print('No date or time selected');
    }
  }

  Future<bool> _checkScheduleExists(Timestamp scheduleTimeStamp) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('kasidit_schedules')
        .where('scheduleTime', isEqualTo: scheduleTimeStamp)
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  void _showScheduleConflictDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Schedule Conflict"),
          content: Text(
              "This schedule time is already booked. Please choose another time."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      appBar: AppBar(
        title: Text(
          'Movie Details',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    movieImagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Display movie details
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    movieTitle,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Genre: $movieGenre',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Length: $movieLength',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Source: $movieSource',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.white,
            ),
            // Display available time slots
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Date Slot:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => _selectDate(context),
                            child: Text('Select Date'),
                          ),
                          SizedBox(width: 8),
                          if (selectedDate != null)
                            Text(
                              selectedDate!.toString().substring(0, 10),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                            ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => _selectTime(context),
                            child: Text('Select Time'),
                          ),
                          SizedBox(width: 8),
                          if (selectedTime != null)
                            Text(
                              'Selected Time: ${selectedTime!.format(context)}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                      SizedBox(height: 8),
                      // Container(
                      //   height: 50, // Set a fixed height for the container
                      //   child: ListView.builder(
                      //     scrollDirection: Axis
                      //         .horizontal, // Set the direction to horizontal
                      //     itemCount: timeSlots.length,
                      //     itemBuilder: (context, index) {
                      //       String timeSlot = timeSlots[index];
                      //       return Container(
                      //         margin: EdgeInsets.symmetric(
                      //             horizontal:
                      //                 4.0), // Margin for spacing between chips
                      //         child: ChoiceChip(
                      //           label: Text(timeSlot),
                      //           selected: selectedTimeSlot == timeSlot,
                      //           onSelected: (bool selected) {
                      //             _selectTimeSlot(timeSlot);
                      //           },
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                    ],
                  ),

                  // Save button
                  Center(
                    child: ElevatedButton(
                      onPressed: _saveSchedule,
                      child: Text('Save Schedule'),
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
}
