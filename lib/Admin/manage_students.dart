import 'package:edu_mate/Admin/register_student.dart';
import 'package:edu_mate/Admin/components/popup_more_student.dart';
import 'package:edu_mate/Admin/components/searchbar.dart';
import 'package:edu_mate/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Managestudents extends StatefulWidget {
  const Managestudents({super.key});

  @override
  State<Managestudents> createState() => _ManagestudentsState();
}

class _ManagestudentsState extends State<Managestudents> {
  List<Map<dynamic, dynamic>> students = [];
  List<Map<dynamic, dynamic>> filteredStudents = [];
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  // Function to fetch students from Firestore
  void _fetchStudents() async {
    try {
      Stream<QuerySnapshot> studentStream = await databaseMethods.getStudents();

      studentStream.listen((QuerySnapshot snapshot) {
        if (snapshot.docs.isNotEmpty) {
          setState(() {
            students = snapshot.docs.map((doc) {
              return {
                'id': doc.id,
                'name': doc['Name'],
                'subjects': doc['Subject'],
              };
            }).toList();
            filteredStudents = List.from(students);
          });
        } else {
          print("No students found in Firestore.");
        }
      });
    } catch (e) {
      print("Error fetching students: $e");
    }
  }

  void _filterStudents(String query) {
    setState(() {
      filteredStudents = students
          .where((student) =>
              student['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          iconSize: 25,
                        ),
                        Spacer(),
                        Text(
                          "Manage Students",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),

              // Search bar section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Searchbar(
                  hintText: "Search for a student",
                  controller: searchController,
                  onChange: _filterStudents,
                ),
              ),

              // List of students wrapped inside a ConstrainedBox
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredStudents.length,
                  itemBuilder: (context, index) {
                    final student = filteredStudents[index];
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
                              height: 50,
                              width: 50,
                            ),
                            SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                    '${student['subjects']}',
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
                              width: 90,
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
                                    GestureDetector(
                                      onTap: () {
                                        PopupMoreStudent(
                                                id: student['id'],
                                                collection: 'Students')
                                            .showPopup(context);
                                      },
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                        size: 25,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Registerstudent(),
            ),
          );
        },
        backgroundColor: Color(0xFF3A2AE0),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
