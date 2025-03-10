import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Attendencecontainer extends StatefulWidget {
  String? stEmail;

  Attendencecontainer({
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
      setState(() {
        subjects = studentSnapshot.docs.first['Subject'];
      });
    }
  }

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
                          color: subject == "Maths"
                              ? Color(0xFFB72CBC)
                              : subject == "Science"
                                  ? const Color.fromARGB(255, 176, 158, 3)
                                  : subject == "English"
                                      ? const Color.fromARGB(255, 2, 91, 164)
                                      : subject == "Commerce"? const Color.fromARGB(255, 164, 99, 3)
                                      : subject == "History"? const Color.fromARGB(255, 168, 13, 2)
                                      : subject == "Sinhala"? const Color.fromARGB(255, 1, 154, 3): const Color.fromARGB(255, 166, 1, 56),
                                      
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
