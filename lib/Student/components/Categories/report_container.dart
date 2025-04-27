import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/Student/components/report_details_card.dart';
import 'package:edu_mate/service/app_logger.dart';
import 'package:flutter/material.dart';

class Reportcontainer extends StatefulWidget {
  final String? stEmail;

  const Reportcontainer({super.key, required this.stEmail});

  @override
  State<Reportcontainer> createState() => _ReportcontainerState();
}

class _ReportcontainerState extends State<Reportcontainer> {
  String? stId;
  Stream<QuerySnapshot<Map<String, dynamic>>>? studentMarksStream;

  @override
  void initState() {
    super.initState();
    getStudentIdAndMarks();
  }

  Future<void> getStudentIdAndMarks() async {
    try {
      var studentSnapshot = await FirebaseFirestore.instance
          .collection("Students")
          .where('Email', isEqualTo: widget.stEmail)
          .get();

      if (studentSnapshot.docs.isNotEmpty) {
        String studentId = studentSnapshot.docs.first.id;

        setState(() {
          stId = studentId;
          studentMarksStream = FirebaseFirestore.instance
              .collection("Students")
              .doc(stId)
              .collection("Marks")
              .orderBy("timestamp", descending: true)
              .snapshots();
        });
      } else {
        AppLogger().w("Student not found!");
      }
    } catch (e) {
      AppLogger().e("Error fetching student ID and marks: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (studentMarksStream == null) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: StreamBuilder(
        stream: studentMarksStream,
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Marks Found"));
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index].data();

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
                        Reportdetailscard(title: "Subject :", data: data["Subject"] ?? "Unknown"),
                        Reportdetailscard(title: "Test No :", data: data["Test No."] ?? "N/A"),
                        Reportdetailscard(title: 'Marks : ', data: "${data["Marks"] ?? "0"}%"),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
