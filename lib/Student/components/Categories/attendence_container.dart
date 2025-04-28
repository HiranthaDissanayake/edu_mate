import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Attendencecontainer extends StatefulWidget {
  final String? stEmail;

  const Attendencecontainer({
    super.key,
    required this.stEmail,
  });

  @override
  State<Attendencecontainer> createState() => _AttendencecontainerState();
}

class _AttendencecontainerState extends State<Attendencecontainer> {
  List<dynamic> subjects = [];

  getonload() async {
    var studentSnapshot = await FirebaseFirestore.instance
        .collection("Students")
        .where("Email", isEqualTo: widget.stEmail)
        .get();

    if (studentSnapshot.docs.isNotEmpty && mounted) {
      var subjectMap =
          studentSnapshot.docs.first['Subject'] as Map<String, dynamic>;
      setState(() {
        subjects = subjectMap.keys.toList();
      });
    }
  }

  final Map<String, Color> subjectColors = {
    "maths": Color(0xFFB72CBC),
    "Science": Color.fromARGB(255, 176, 158, 3),
    "English": Color.fromARGB(255, 2, 91, 164),
    "Commerce": Color.fromARGB(255, 164, 99, 3),
    "History": Color.fromARGB(255, 168, 13, 2),
    "Sinhala": Color.fromARGB(255, 1, 154, 3),
  };

  @override
  void initState() {
    super.initState();
    getonload();
  }

  @override
  Widget build(BuildContext context) {
    return subjects.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: subjects
                .map((subject) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 60,
                        decoration: BoxDecoration(
                          color: subjectColors[subject] ??
                              Color.fromARGB(255, 166, 1,
                                  56), // default color if not found
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            subject,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          );
  }
}
