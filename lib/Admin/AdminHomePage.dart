import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/Admin/DrawerMenu.dart';
import 'package:edu_mate/Admin/ManageStudents.dart';
import 'package:edu_mate/service/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Adminhomepage extends StatefulWidget {
  const Adminhomepage({super.key});

  @override
  State<Adminhomepage> createState() => _AdminhomepageState();
}

class _AdminhomepageState extends State<Adminhomepage> {
  Stream<QuerySnapshot>? StudentStream;
  Stream<QuerySnapshot>? TeacherStream;

  Future<void> getonetheload() async {
    try {
      StudentStream = await DatabaseMethods().getStudents();
      TeacherStream = await DatabaseMethods().getTeachers();
      setState(() {
        StudentStream;
        TeacherStream;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getonetheload();
  }

  // ignore: non_constant_identifier_names
  Widget NumberOfStudents() {
    return StreamBuilder<QuerySnapshot>(
        stream: StudentStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text("No students found");
          }

          int studentCount = snapshot.data!.docs.length; // Get total count
          return Text(
            "$studentCount",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          );
        });
  }

  // ignore: non_constant_identifier_names
  Widget NumberOfTeachers() {
    return StreamBuilder<QuerySnapshot>(
        stream: TeacherStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text("No Teachers found");
          }

          int teacherCount = snapshot.data!.docs.length; // Get total count
          return Text(
            "$teacherCount",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawermenu(),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF13134C), const Color(0XFF2D2DB2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xFF080B2E),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )),
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xFF010127),
                                const Color(0xFF0B0C61)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(70),
                              topRight: Radius.circular(150))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          children: [
                            Expanded(
                                child: Builder(
                              builder: (context) => IconButton(
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                icon: Icon(Icons.menu),
                                color: Color(0xFF5BAFDB),
                                iconSize: 40,
                              ),
                            )),
                            SizedBox(
                              width: 60,
                            ),
                            Expanded(
                              child: Text(
                                "EduMate",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            Image(
                                image: AssetImage("assets/images/AppLogo.png")),
                            Text(
                              "EduMate",
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 22),
                            ),
                            Text(
                              "Admin Panel",
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: const Color(0xFF181A47),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total Number Of Students",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF282845),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: NumberOfStudents(),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total Number Of Teachers",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF282845),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: NumberOfTeachers(),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xFF3A2AE0),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Schedule Classes ",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xFF080B2E),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Managestudents()));
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image:
                                        AssetImage("assets/images/student.png"),
                                    width: 35,
                                    height: 35,
                                  ),
                                  Text("Student",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              //type the code
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image:
                                        AssetImage("assets/images/teacher.png"),
                                    width: 35,
                                    height: 35,
                                  ),
                                  Text("Teachers",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              //type the code
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image:
                                        AssetImage("assets/images/report.png"),
                                    width: 35,
                                    height: 35,
                                  ),
                                  Text("Reports",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))),
              )
            ],
          ),
        ));
  }
}
