import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/Admin/components/generate_schedule_pdf.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ClassFeeScreenState();
}

class _ClassFeeScreenState extends State<ScheduleScreen> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchScheduleDetails();
  }

  Future<List<Map<String, dynamic>>> getSchedules() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("Schedules").get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  void fetchScheduleDetails() async {
    List<Map<String, dynamic>> fetchedData = await getSchedules();
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
              DataColumn(label: Text("Subject")),
              DataColumn(label: Text("Grade")),
              DataColumn(label: Text("StartTime")),
              DataColumn(label: Text("EndTime")),
              DataColumn(label: Text("ClassDay")),
              DataColumn(label: Text("ClassFee"))
            ],
            rows: data
                .map((item) => DataRow(cells: [
                      DataCell(Text(item['TeacherId'].toString())),
                      DataCell(Text(item['Subject'].toString())),
                      DataCell(Text(item['Grade'].toString())),
                      DataCell(Text(item['StartTime'].toString())),
                      DataCell(Text(item['EndTime'].toString())),
                      DataCell(Text(item['ClassDay'].toString())),
                      DataCell(Text(item['ClassFee'].toString()))
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
                    generateSchedulePDF(data);
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
