import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/Admin/components/generate_teacher_pdf.dart';
import 'package:flutter/material.dart';

class TeacherDetails extends StatefulWidget {
  const TeacherDetails({super.key});

  @override
  State<TeacherDetails> createState() => _ClassFeeScreenState();
}

class _ClassFeeScreenState extends State<TeacherDetails> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchTeacherDetails();
  }

  Future<List<Map<String, dynamic>>> getTeachers() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("Teachers").get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  void fetchTeacherDetails() async {
    List<Map<String, dynamic>> fetchedData = await getTeachers();
    setState(() {
      data = fetchedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            columns: [
              DataColumn(label: Text("TeacherId")),
              DataColumn(label: Text("Name")),
              DataColumn(label: Text("Subject")),
              DataColumn(label: Text("Qualification")),
              DataColumn(label: Text("ContactNo")),
              DataColumn(label: Text("Email"))
            ],
            rows: data
                .map((item) => DataRow(cells: [
                      DataCell(Text(item['TeacherId'].toString())),
                      DataCell(Text(item['Name'].toString())),
                      DataCell(Text(item['Subject'].toString())),
                      DataCell(Text(item['Qualification'].toString())),
                      DataCell(Text(item['ContactNo'].toString())),
                      DataCell(Text(item['Email'].toString()))
                    ]))
                .toList()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Export Report"),
              content: Text("Choose export format"),
              actions: [
                TextButton(
                  onPressed: () {
                    generateTeacherPDF(data);
                    Navigator.pop(context);
                  },
                  child: Text("PDF"),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
