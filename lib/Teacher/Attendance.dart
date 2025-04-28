import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Attendance extends StatefulWidget {
  final String teacherID;
  final String grade;

  const Attendance({required this.teacherID, required this.grade, super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  Map<String, int> attendanceStatus = {};

  Future<void> markAttendance(
      String studentId, String status, String teacherID) async {
    try {
      DocumentSnapshot teacherSnapshot = await FirebaseFirestore.instance
          .collection('Teachers')
          .doc(teacherID)
          .get();

      if (teacherSnapshot.exists) {
        String teacherSub = teacherSnapshot['Subject'];
        String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
        String monthYear = DateFormat('yyyy-MM').format(DateTime.now());

        await FirebaseFirestore.instance
            .collection('Students')
            .doc(studentId)
            .update({'Subject.$teacherSub.$monthYear.$today': status});

        print("Attendance marked successfully");
      } else {
        print('Teacher document not found');
      }
    } catch (e) {
      print('Error marking attendance: $e');
    }
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
                        Navigator.pop(context);
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
                    SizedBox(width: 40),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Students')
                    .where('Grade', isEqualTo: widget.grade)
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

                  return FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('Teachers')
                        .doc(widget.teacherID)
                        .get(),
                    builder: (context, teacherSnapshot) {
                      if (!teacherSnapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final teacherData =
                          teacherSnapshot.data!.data() as Map<String, dynamic>;
                      final teacherSubject = teacherData['Subject'];

                      final filteredStudents = snapshot.data!.docs.where((doc) {
                        final studentData =
                            doc.data() as Map<String, dynamic>;
                        final subjects = studentData['Subject'] ?? {};
                        return subjects.containsKey(teacherSubject);
                      }).toList();

                      if (filteredStudents.isEmpty) {
                        return Center(
                          child: Text(
                            "No students found for selected subject",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: filteredStudents.length,
                        itemBuilder: (context, index) {
                          final doc = filteredStudents[index];
                          final studentId = doc.id;
                          final studentName = doc['Name'];

                          int currentAttendanceStatus =
                              attendanceStatus[studentId] ?? 0;

                          return Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            color: Color(0xFF080B2E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              leading: ClipOval(
                                child: Image.network(
                                  (doc.data() as Map<String, dynamic>)
                                          .containsKey('imageURL')
                                      ? (doc.data() as Map<String, dynamic>)[
                                          'imageURL']
                                      : 'https://drive.google.com/uc?export=view&id=1cogzIZVFFQMgVfr8emlld-PclxPUzqpv',
                                  height: 40,
                                  width: 40,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      'https://drive.google.com/uc?export=view&id=1cogzIZVFFQMgVfr8emlld-PclxPUzqpv',
                                      height: 40,
                                      width: 40,
                                    );
                                  },
                                ),
                              ),
                              title: Text(
                                studentName,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    currentAttendanceStatus == 0
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                attendanceStatus[studentId] = 1;
                                              });
                                              markAttendance(studentId, 'Present',
                                                  widget.teacherID);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 0),
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
                                              markAttendance(studentId, 'Absent',
                                                  widget.teacherID);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                              markAttendance(studentId, 'Absent',
                                                  widget.teacherID);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 0),
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
                                              markAttendance(studentId, 'Present',
                                                  widget.teacherID);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                        },
                      );
                    },
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
