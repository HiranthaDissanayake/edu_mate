import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/Admin/UpdateScheduleScreen.dart';
import 'package:flutter/material.dart';
import 'package:edu_mate/service/database.dart';

class Manageschedules extends StatefulWidget {
  const Manageschedules({super.key});

  @override
  State<Manageschedules> createState() => _ManageschedulesState();
}

class _ManageschedulesState extends State<Manageschedules> {
  List<Map<String, dynamic>> schedules = [];
  List<Map<String, dynamic>> filteredSchedules = [];
  List<Map<String, dynamic>> teachers = [];
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTeachers();
    _fetchSchedules();
  }

  void _fetchTeachers() async {
    try {
      Stream<QuerySnapshot> teacherStream = await databaseMethods.getTeachers();

      teacherStream.listen((QuerySnapshot snapshot) {
        if (snapshot.docs.isNotEmpty) {
          setState(() {
            teachers = snapshot.docs.map((doc) {
              return {
                'id': doc['TeacherId'],
                'name': doc['Name'],
                'subjects': doc['Subject'],
              };
            }).toList();
          });
        } else {
          print("No teachers found in Firestore.");
        }
      });
    } catch (e) {
      print("Error fetching teachers: $e");
    }
  }

  void _fetchSchedules() async {
    try {
      Stream<QuerySnapshot> scheduleStream =
          await databaseMethods.getSchedules();

      scheduleStream.listen((QuerySnapshot snapshot) {
        if (snapshot.docs.isNotEmpty) {
          setState(() {
            schedules = snapshot.docs.map((doc) {
              return {
                'id': doc.id,
                'teacherId': doc['TeacherId'],
                'subject': doc['Subject'],
                'grade': doc['Grade'],
                'classDay': doc['ClassDay'],
                'startTime': doc['StartTime'],
                'endTime': doc['EndTime'],
              };
            }).toList();
            filteredSchedules = List.from(schedules);
          });
        } else {
          print("No schedules found in Firestore.");
        }
      });
    } catch (e) {
      print("Error fetching schedules: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF13134C), Color(0xFF13134C), Color(0XFF2D2DB2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF010127), Color(0xFF0B0C61)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  topRight: Radius.circular(150),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 25,
                    ),
                    Spacer(),
                    Text(
                      "Manage Schedules",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10),
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  final schedule = filteredSchedules[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF080B2E),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${teachers.firstWhere((teacher) => teacher['id'] == schedule['teacherId'])['name']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Text(
                                  "${schedule['subject']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "${schedule['grade']}",
                                  style: TextStyle(
                                    color: Colors.yellow.shade200,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Day: ${schedule['classDay']}",
                                  style: TextStyle(
                                    color: Colors.yellow.shade200,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Time: ${schedule['startTime']} - ${schedule['endTime']}",
                                  style: TextStyle(
                                    color: Colors.yellow.shade200,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              // Add action for schedule options
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Updateschedulescreen(
                                              scheduleId: schedule['id'],
                                              teacherId:
                                                  schedule['teacherId'])));
                            },
                            child: Icon(
                              Icons.mode_edit_rounded,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
