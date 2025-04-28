import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Classescontainer extends StatefulWidget {
  final String stEmail;
  const Classescontainer({
    super.key,
    required this.stEmail,
  });

  @override
  State<Classescontainer> createState() => _ClassescontainerState();
}

class _ClassescontainerState extends State<Classescontainer> {
  String? stGrade = "";

  Stream? studentStream;
  Stream? teacherStream;
  Stream? scheduleStream;

  getonload() async {
    var studentSnapshot = await FirebaseFirestore.instance
        .collection("Students")
        .where('Email', isEqualTo: widget.stEmail)
        .get();

    if (studentSnapshot.docs.isNotEmpty && mounted) {
      setState(() {
        stGrade = studentSnapshot.docs.first['Grade'];
      });
    }

    if (!mounted) return; // Prevents calling setState() on disposed widget

    studentStream = FirebaseFirestore.instance
        .collection("Students")
        .where('Email', isEqualTo: widget.stEmail)
        .snapshots();

    teacherStream = FirebaseFirestore.instance
        .collection("Teachers")
        .where('Grade', arrayContains: stGrade)
        .snapshots();

    scheduleStream = FirebaseFirestore.instance
        .collection("Schedules")
        .where('Grade', isEqualTo: stGrade)
        .snapshots();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getonload();
  }

  Widget studentDetails() {
    return StreamBuilder(
      stream: studentStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Center(
            child: Text(
              "No Subjects Found",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 17),
            ),
          );
        }

        DocumentSnapshot ds = snapshot.data.docs[0];
        Map<String, dynamic> subjectMap = ds['Subject'];
        List<String> subjects = subjectMap.keys.toList(); // Subject names only

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF26284A),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Subjects:",
                style: GoogleFonts.poppins(
                  color: Colors.deepOrange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ...subjects.map((subject) => Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "$subject",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget scheduleDetails() {
    return StreamBuilder(
      stream: scheduleStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: snapshot.data.docs.map<Widget>((doc) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Color(0xFF26284A),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Subject: ${doc['Subject']}",
                    style: GoogleFonts.poppins(
                      color: Colors.deepOrange,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Class : $stGrade",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Class Day: ${doc['ClassDay']}",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Time: ${doc['StartTime']}   -${doc['EndTime']}",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget teacherDetails() {
    return StreamBuilder(
      stream: teacherStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: snapshot.data.docs.map<Widget>((doc) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Color(0xFF26284A),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stGrade.toString(),
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Subject: ${doc['Subject']}",
                    style: GoogleFonts.poppins(
                      color: Colors.deepOrange,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Teacher: ${doc['Name']}",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Registered Subjects List",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            studentDetails(),
            SizedBox(height: 20),
            Text(
              "Teachers Details",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            teacherDetails(),
            SizedBox(height: 20),
            Text(
              "Schedule Details",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            scheduleDetails(),
          ],
        ),
      ),
    );
  }
}
