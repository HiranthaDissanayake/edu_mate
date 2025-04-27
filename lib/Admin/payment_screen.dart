import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/Admin/components/searchbar.dart';
import 'package:edu_mate/service/app_logger.dart';
import 'package:edu_mate/service/database_methods.dart';
import 'package:flutter/material.dart';

class Paymentscreen extends StatefulWidget {
  const Paymentscreen({super.key});

  @override
  State<Paymentscreen> createState() => _PaymentscreenState();
}

class _PaymentscreenState extends State<Paymentscreen> {
  List<Map<dynamic, dynamic>> students = [];
  List<Map<dynamic, dynamic>> filteredStudents = [];
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchController = TextEditingController();

  Set<String> paidSubjects = {};

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  // Function to fetch students and check their payment status
  void _fetchStudents() async {
    try {
      Stream<QuerySnapshot> studentStream = await databaseMethods.getStudents();
      String currentMonth =
          "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}";

      studentStream.listen((QuerySnapshot snapshot) async {
        if (snapshot.docs.isNotEmpty) {
          List<Map<dynamic, dynamic>> tempStudents = [];
          Set<String> tempPaidSubjects = {};

          for (var doc in snapshot.docs) {
            Map<String, dynamic> subjects = doc['Subject'] ?? {};
            for (var subject in subjects.keys) {
              // Ensure we skip attendance dates inside subjects
              if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(subject)) {
                // Check if payment is done
                bool isPaid =
                    await _checkPaymentStatus(doc.id, currentMonth, subject);
                if (isPaid) {
                  tempPaidSubjects.add("${doc.id}-$subject");
                }

                tempStudents.add({
                  'id': doc.id,
                  'name': doc['Name'],
                  'subject': subject,
                });
              }
            }
          }

          setState(() {
            students = tempStudents;
            filteredStudents = List.from(tempStudents);
            paidSubjects = tempPaidSubjects;
          });
        } else {
          AppLogger().w("No students found in Firestore.");
        }
      });
    } catch (e) {
      AppLogger().e("Error fetching students: $e");
    }
  }

  // Check payment status for a student
  Future<bool> _checkPaymentStatus(
      String studentId, String month, String subject) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Payment')
        .where('studentId', isEqualTo: studentId)
        .where('month', isEqualTo: month)
        .where('subject', isEqualTo: subject)
        .where('isPaid', isEqualTo: true) // Only check for paid records
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  // Function to mark a student as paid
  void _markAsPaid(String studentId, String subject) {
    setState(() {
      paidSubjects.add("$studentId-$subject");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF13134C),
              const Color(0xFF13134C),
              const Color(0XFF2D2DB2)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Top appbar
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF010127), const Color(0xFF0B0C61)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  topRight: Radius.circular(150),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        iconSize: 25,
                      );
                    }),
                    Text(
                      "Payments",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 48,
                    )
                  ],
                ),
              ),
            ),

            // Search bar section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Searchbar(
                hintText: "Search for a student",
                controller: searchController,
                onChange: (query) {
                  setState(() {
                    filteredStudents = students
                        .where((student) => student['name']
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),

            // List of students wrapped inside an Expanded widget
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = filteredStudents[index];
                  bool isPaid = paidSubjects
                      .contains("${student['id']}-${student['subject']}");

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF080B2E),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Image.asset(
                            'assets/images/student_logo.png',
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student['name'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  student['subject'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 100,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Color(0xFF32325F),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isPaid
                                          ? Color(0xFF009d00)
                                          : Color(0xFF2D2DB2),
                                      disabledBackgroundColor: Color(
                                          0xFF009d00), // Ensure green when disabled
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: isPaid
                                        ? null
                                        : () async {
                                            String currentMonth =
                                                "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}";

                                            bool success = await databaseMethods
                                                .updatePaymentStatus(
                                              studentId: student['id'],
                                              month: currentMonth,
                                              subject: student['subject'],
                                            );

                                            if (success) {
                                              _markAsPaid(student['id'],
                                                  student['subject']);
                                            }
                                          },
                                    child: Text(
                                      isPaid ? "Paid" : "Pay",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${student['id']}\nID',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
