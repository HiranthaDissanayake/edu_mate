import 'package:edu_mate/Teacher/attendance.dart';
import 'package:edu_mate/Teacher/marks_screen.dart';
import 'package:edu_mate/Teacher/send_alerts.dart';
import 'package:edu_mate/Teacher/payments.dart';
import 'package:flutter/material.dart';
import 'package:edu_mate/Teacher/components/drawer.dart';

class Teacherdashboard extends StatefulWidget {
  final String grade;

  const Teacherdashboard({super.key, required this.grade});

  @override
  State<Teacherdashboard> createState() => _TeacherdashboardState();
}

class _TeacherdashboardState extends State<Teacherdashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavBar(),
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
                            'Sandeepa Minol',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            'Bsc(hons) in Software Engineering',
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
                  Text(
                    '     Today\nAttendance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
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
                  width: 210,
                  decoration: BoxDecoration(
                    color: Color(0xFF181C5C),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Center(
                    child: Text(
                      'Upcoming Classes Today',
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
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF10183C),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        children: [
                          Text(
                            'Grade 7 English',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '8.00 a.m - 10.00 a.m',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        children: [
                          Text(
                            'Grade 7 English',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '8.00 a.m - 10.00 a.m',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        children: [
                          Text(
                            'Grade 7 English',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '8.00 a.m - 10.00 a.m',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        children: [
                          Text(
                            'Grade 7 English',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '8.00 a.m - 10.00 a.m',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        children: [
                          Text(
                            'Grade 7 English',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '8.00 a.m - 10.00 a.m',
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
                                builder: (context) => Marksscreen()),
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
                                builder: (context) => Sendalerts()),
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
                                builder: (context) => Attendance()),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
