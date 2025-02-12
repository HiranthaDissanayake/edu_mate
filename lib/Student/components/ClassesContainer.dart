import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/Student/components/subjectDetailsCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Classescontainer extends StatefulWidget {
  String stId;
   Classescontainer({
    super.key,
    required this.stId,
    });

  @override
  State<Classescontainer> createState() => _ClassescontainerState();
}

class _ClassescontainerState extends State<Classescontainer> {

  Stream? studentStream;
  Stream? teacherStream;

Widget studentDetails() {
  return StreamBuilder(
    stream: studentStream,
    builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData
          ? ListView.builder(
              itemCount: snapshot.data.docs['id'] == widget.stId 
                  ? snapshot.data.docs.length 
                  : 0,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20, right: 10, top: 8, bottom: 8
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Subjectdetailscard(title: "Subject", data: ds['Subject']),
                            // Subjectdetailscard(title: "Teacher", data: "Sarath Kumara"),
                            // Subjectdetailscard(title: "Date", data: "Saturday"),
                            // Subjectdetailscard(title: "Time", data: "8.00am - 10.00am"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFFB2383A),
                          ),
                          child: Center(
                            child: Text(
                              "Pay",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          : Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                
              )),
          ); // Add a fallback widget if no data is available
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 160,
      decoration: BoxDecoration(
        color: Color(0xFF26284A),
        borderRadius: BorderRadius.circular(30),
      ),
      child: studentDetails(),
    );
  }
}
