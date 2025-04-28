import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/Admin/components/searchbar.dart';
import 'package:edu_mate/service/app_logger.dart';
import 'package:edu_mate/service/database_methods.dart';
import 'package:url_launcher/url_launcher.dart';

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
              if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(subject)) {
                bool isPaid =
                    await _checkPaymentStatus(doc.id, currentMonth, subject);
                if (isPaid) {
                  tempPaidSubjects.add("${doc.id}-$subject");
                }

                tempStudents.add({
                  'id': doc.id,
                  'name': doc['Name'],
                  'subject': subject,
                  'parentPhone': doc['ParentNo'],
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

  Future<bool> _checkPaymentStatus(
      String studentId, String month, String subject) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Payment')
        .where('studentId', isEqualTo: studentId)
        .where('month', isEqualTo: month)
        .where('subject', isEqualTo: subject)
        .where('isPaid', isEqualTo: true)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  void _markAsPaid(String studentId, String subject) {
    setState(() {
      paidSubjects.add("$studentId-$subject");
    });
  }

  Future<void> _sendPaymentSMS(
      String phoneNumber, String studentName, String subject) async {
    final currentMonth = "${DateTime.now().month}/${DateTime.now().year}";
    final message =
        "Dear Parent, payment for $subject for $currentMonth has been received for $studentName. Thank you!";

    final Uri uri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {'body': message},
    );

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        AppLogger().e("Could not launch SMS app");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Could not open messaging app")),
        );
      }
    } catch (e) {
      AppLogger().e("Error sending SMS: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error sending SMS")),
      );
    }
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
            // Top appbar (unchanged)
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

            // Search bar section (unchanged)
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

            // List of students
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
                                      disabledBackgroundColor:
                                          Color(0xFF009d00),
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
                                              // Send SMS to parent
                                              if (student['parentPhone'] !=
                                                      null &&
                                                  student['parentPhone']
                                                      .isNotEmpty) {
                                                _sendPaymentSMS(
                                                  student['parentPhone'],
                                                  student['name'],
                                                  student['subject'],
                                                );
                                              }
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
