import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:edu_mate/Teacher/TeacherDashboard.dart';
import 'package:edu_mate/service/database.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  // A map to hold attendance status for each student
  Map<String, int> attendanceStatus = {}; 

  @override
  void initState() {
    super.initState();
    DatabaseMethods()
        .addAttendanceFieldToAllStudents(); // Call once to update all students
  }

  // Function to mark attendance
  Future<void> markAttendance(String studentId, String status) async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String monthYear = DateFormat('yyyy-MM').format(DateTime.now());

    await FirebaseFirestore.instance
        .collection('Students')
        .doc(studentId)
        .update({'attendance.$monthYear.$today': status});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C2C88), Color(0xFF0B0B22)],
            stops: [0.15, 0.4],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          children: [
            // Header Container
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(125),
                  bottomLeft: Radius.circular(65),
                ),
                gradient: LinearGradient(
                  colors: [Color(0xFF010127), Color(0xFF0B0C61)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Teacherdashboard()),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                    Text(
                      'Mark Attendance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    Text("      "),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            // Display List of Students
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Students')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "No students found",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
                  }

                  // Display students list
                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      String studentId = doc.id;
                      String studentName = doc['Name'];
                      
                      String imageURL = doc['imageURL'] ?? '';

                      // Get attendance status for the student if exists
                      int currentAttendanceStatus = attendanceStatus[studentId] ?? 0;

                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        color: Color(0xFF080B2E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Image.network('https://drive.google.com/uc?export=view&id=1GYrvrGb9OijZNuc5dUur5MKHvG79qH5m',
                            fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            studentName,
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          trailing: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              border: Border.all(
                               width: 2,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Show "Present" or "Absent" based on current status
                                currentAttendanceStatus == 0
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            attendanceStatus[studentId] = 1;
                                          });
                                          markAttendance(studentId, 'Present');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 0),
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            attendanceStatus[studentId] = 0;
                                          });
                                          markAttendance(studentId, 'Absent');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Absent',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                currentAttendanceStatus == 1
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            attendanceStatus[studentId] = 0;
                                          });
                                          markAttendance(studentId, 'Absent');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 0),
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            attendanceStatus[studentId] = 1;
                                          });
                                          markAttendance(studentId, 'Present');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Present',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
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
