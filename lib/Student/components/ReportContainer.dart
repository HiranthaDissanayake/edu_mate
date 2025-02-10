import 'package:edu_mate/Student/components/reportDetailsCard.dart';
import 'package:flutter/material.dart';

class Reportcontainer extends StatefulWidget {
  const Reportcontainer({super.key});

  @override
  State<Reportcontainer> createState() => _ReportcontainerState();
}

class _ReportcontainerState extends State<Reportcontainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 140,
      decoration: BoxDecoration(
        color: Color(0xFF26284A),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Expanded(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 10, top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Reportdetailscard(title: "Subject", data: "Mathematics"),
                 Reportdetailscard(title: "Paper Name", data: "Test 01"),
                 Reportdetailscard(title: 'Marks', data: "75%")
                ],
              ),
            ),
          ),
    );
  }
}
