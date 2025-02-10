import 'package:edu_mate/Student/components/subjectDetailsCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Classescontainer extends StatefulWidget {
  const Classescontainer({super.key});

  @override
  State<Classescontainer> createState() => _ClassescontainerState();
}

class _ClassescontainerState extends State<Classescontainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 160,
      decoration: BoxDecoration(
        color: Color(0xFF26284A),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 10, top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Subjectdetailscard(title: "Subject", data: "Mathematics"),
                  Subjectdetailscard(title: "Teacher", data: "Sarath Kumara"),
                  Subjectdetailscard(title: "Date", data: "Saturday"),
                  Subjectdetailscard(title: "Time", data: "8.00am - 10.00am"),
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
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ))
        ],
      ),
    );
  }
}
