import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Viewmarks extends StatefulWidget {

  final String grade;

  const Viewmarks({
    required this.grade,
    super.key
    });

  @override
  State<Viewmarks> createState() => _ViewmarksState();
}

class _ViewmarksState extends State<Viewmarks> {

  Future<List<Map<String, dynamic>>> fetchStudentMarks(String studentID) async {
    print("Fetching marks for Student ID: $studentID");

    List<Map<String, dynamic>> marksList = [];
    QuerySnapshot marksSnapshot = await FirebaseFirestore.instance
        .collection('Students')
        // .where('Grade', isEqualTo: widget.grade)
        .doc(studentID)
        .collection('Marks')
        .get();

    print("Total documents found: ${marksSnapshot.docs.length}");

    for (var doc in marksSnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>; 
      print("Document Data: $data");

      if (data.containsKey('Test No.') &&
          data.containsKey('Marks') &&
          data.containsKey('Subject')) {
        marksList.add({
          'Test No': data['Test No.'], 
          'Subject': data['Subject'],
          'Marks': data['Marks'],
        });
      } else {
        print("Skipping document due to missing fields: $data");
      }
    }

    print("Final Marks List: $marksList"); 
    return marksList;
  }

  @override
  Widget build(BuildContext context) {
    String studentID = "5275B9t1R8";

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C2C88), Color(0xFF0B0B22)],
            stops: [0.15, 0.4],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(125),
                    bottomLeft: Radius.circular(65)),
                gradient: LinearGradient(
                  colors: [Color(0xFF010127), Color(0xFF0B0C61)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                    Text(
                      'View Student Marks',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(width: 40),
                  ],
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: fetchStudentMarks(studentID),
              builder: (context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                print("FutureBuilder State: ${snapshot.connectionState}");

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  print("No student marks available");
                  return Center(child: Text('No student marks available'));
                }

                List<Map<String, dynamic>> marksData = snapshot.data!;
                print("Building DataTable with ${marksData.length} rows");

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(
                          label: Text('Test No',
                              style: TextStyle(color: Colors.white))),
                      DataColumn(
                          label: Text('Subject',
                              style: TextStyle(color: Colors.white))),
                      DataColumn(
                          label: Text('Marks',
                              style: TextStyle(color: Colors.white))),
                    ],
                    rows: marksData.map((mark) {
                      print("Rendering row: $mark");
                      return DataRow(cells: [
                        DataCell(Text(mark['Test No'].toString(),
                            style: TextStyle(color: Colors.white))),
                        DataCell(Text(mark['Subject'],
                            style: TextStyle(color: Colors.white))),
                        DataCell(Text(mark['Marks'].toString(),
                            style: TextStyle(color: Colors.white))),
                      ]);
                    }).toList(),
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
