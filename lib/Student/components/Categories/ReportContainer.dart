import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/Student/components/reportDetailsCard.dart';
import 'package:flutter/material.dart';

class Reportcontainer extends StatefulWidget {
  String? stEmail;
   Reportcontainer({
    super.key,
    required this.stEmail,
    
    });

  @override
  State<Reportcontainer> createState() => _ReportcontainerState();
}

class _ReportcontainerState extends State<Reportcontainer> {

  String? stId;

  Stream<DocumentSnapshot<Map<String, dynamic>>>? studentMarksStream;

  getonload() async {

      var studentSnapshot = await FirebaseFirestore.instance
      .collection("Students")
      .where('Email', isEqualTo: widget.stEmail)
      .get();

      if (studentSnapshot.docs.isNotEmpty && mounted) {
        setState(() {
          stId = studentSnapshot.docs.first['id'];
      });
  }

    studentMarksStream = FirebaseFirestore.instance
        .collection("Students")
        .doc(stId) // Student ID
        .collection("Marks") // Make sure this matches Firestore structure
        .doc("History") // Subject Name
        .snapshots();

    if (mounted) {
      setState(() {}); // Ensure UI updates when stream is set
    }
  }
  

  @override
  void initState() {
    super.initState();
    getonload();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: studentMarksStream,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("No marks found"));
          }

          // Extracting data from Firestore
          var data = snapshot.data!.data() as Map<String, dynamic>;
          String subject = data["subject"] ?? "Unknown";
          String testNo = data["test"] ?? "N/A";
          String marks = data["marks"] ?? "0%";

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 140,
              decoration: BoxDecoration(
                color: Color(0xFF26284A),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 10, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Reportdetailscard(title: "Subject :", data: subject),
                    Reportdetailscard(title: "Paper Name :", data: testNo),
                    Reportdetailscard(title: 'Marks : ', data: "$marks%"),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
