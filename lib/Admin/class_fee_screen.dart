import 'package:edu_mate/Admin/components/generate_pdf.dart';
import 'package:edu_mate/service/database.dart';
import 'package:flutter/material.dart';

class ClassFeeScreen extends StatefulWidget {
  const ClassFeeScreen({super.key});

  @override
  State<ClassFeeScreen> createState() => _ClassFeeScreenState();
}

class _ClassFeeScreenState extends State<ClassFeeScreen> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchPaymentRecords();
  }

  void fetchPaymentRecords() async {
    List<Map<String, dynamic>> fetchedData =
        await DatabaseMethods().fetchPaymentRecords();
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
              DataColumn(label: Text("Student ID")),
              DataColumn(label: Text("Subject")),
              DataColumn(label: Text("Is Paid")),
              DataColumn(label: Text("Month"))
            ],
            rows: data
                .map((item) => DataRow(cells: [
                      DataCell(Text(item['studentId'].toString())),
                      DataCell(Text(item['subject'].toString())),
                      DataCell(Text(item['isPaid'] == true ? "Yes" : "No")),
                      DataCell(Text(item['month'].toString()))
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
                    generatePDF(data);
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
