import 'package:edu_mate/Teacher/Attendance.dart';
import 'package:edu_mate/Teacher/SendAlerts.dart';
import 'package:edu_mate/Teacher/StudentList.dart';
import 'package:edu_mate/Teacher/ViewMarks.dart';
import 'package:edu_mate/Teacher/payments.dart';
import 'package:flutter/material.dart';
import 'package:edu_mate/Teacher/components/drawer.dart';
import 'package:edu_mate/Teacher/components/teacher.dart';
import 'package:edu_mate/service/database_methods.dart';

class Teacherdashboard extends StatefulWidget {
  final String teacherID;
  final Teacher teacherData;
  String grade;

  Teacherdashboard({
    super.key,
    required this.teacherID,
    required this.teacherData,
    required this.grade,
  });

  @override
  State<Teacherdashboard> createState() => _TeacherdashboardState();
}

class _TeacherdashboardState extends State<Teacherdashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavBar(teacherID: widget.teacherID, teacherEmail: widget.teacherData.email),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B0B22), Color(0xFF2C2C88)],
            stops: [0.6, 0.72],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2C2C88), Color(0xFF0B0B22)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(125),
                  bottomLeft: Radius.circular(65),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 65, left: 18),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      icon: Icon(Icons.menu),
                      color: Colors.white,
                      iconSize: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.teacherData.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            widget.teacherData.qualification,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 80, right: 80, bottom: 30),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 58,
                      backgroundColor: Color(0xFF141145),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 9,
                          ),
                          Text(
                            '295', //display the attendance today
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            'out of',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '300',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        widget.grade,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '     Today\nAttendance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Container(
                  height: 30,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Color(0xFF181C5C),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Center(
                    child: Text(
                      'Upcoming Classes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Container(
                height: 260, 
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF10183C),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future:
                      DatabaseMethods().getTeacherSchedules(widget.teacherID),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text("No schedules found",
                            style: TextStyle(color: Colors.white)),
                      );
                    }

                    List<Map<String, dynamic>> schedules = snapshot.data!;

                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: schedules.map((schedule) {
                            return Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Card(
                                color: Color(0xFF26284A),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${schedule['Grade']} - ${schedule['ClassDay']}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        "${schedule['StartTime']} - ${schedule['EndTime']}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40, left: 120, right: 120),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentList(
                                  teacherID: widget.teacherID,
                                  grade: widget.grade
                                  ),
                                ),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFF3A2AE0),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.post_add_rounded,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  'Add Marks',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 120, right: 120),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Sendalerts(
                                  // grade: widget.grade
                                )),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFF3A2AE0),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.forward_to_inbox,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  'Send Alerts',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 120, right: 120),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Payments()),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFF3A2AE0),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.find_in_page,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  'View Payments',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 120, right: 120),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Attendance(
                                  teacherID: widget.teacherID,
                                  grade: widget.grade,
                                )),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFF3A2AE0),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.fact_check,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  'Attendance',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 120, right: 120),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Viewmarks(
                                  grade: widget.grade
                                )),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFF3A2AE0),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.view_cozy_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  'View Marks',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
