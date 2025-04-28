import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/Admin/drawer_menu.dart';
import 'package:edu_mate/Admin/manage_schedules.dart';
import 'package:edu_mate/Admin/manage_students.dart';
import 'package:edu_mate/Admin/manage_teachers.dart';
import 'package:edu_mate/Admin/payment_screen.dart';
import 'package:edu_mate/Admin/report_generate.dart';
import 'package:edu_mate/service/app_logger.dart';
import 'package:edu_mate/service/database_methods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Adminhomepage extends StatefulWidget {
  const Adminhomepage({super.key});

  @override
  State<Adminhomepage> createState() => _AdminhomepageState();
}

class _AdminhomepageState extends State<Adminhomepage> {


  Stream<QuerySnapshot>? studentStream;
  Stream<QuerySnapshot>? teacherStream;

  Future<void> getonetheload() async {
    try {
      studentStream = await DatabaseMethods().getStudents();
      teacherStream = await DatabaseMethods().getTeachers();
      setState(() {
        studentStream;
        teacherStream;
      });
    } catch (e) {
      AppLogger().e("Error fetching data: $e");
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
        stream: studentStream,
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
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          );
        });
  }

  // ignore: non_constant_identifier_names
  Widget NumberOfTeachers() {
    return StreamBuilder<QuerySnapshot>(
        stream: teacherStream,
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
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawermenu(),
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
          child: Column(
            children: [
              // App Bar Section
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF080B2E),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    // Top App Bar
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF010127),
                            const Color(0xFF010127),
                            const Color(0xFF0B0C61)
                          ],
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
                            Builder(
                              builder: (context) => IconButton(
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                icon: Icon(Icons.menu),
                                color: Color(0xFF5BAFDB),
                                iconSize: 28,
                              ),
                            ),
                            Text(
                              "EduMate",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: 48), // Placeholder for balance
                          ],
                        ),
                      ),
                    ),
                    // Logo and Title
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage("assets/images/AppLogo.png"),
                            width: 100,
                            height: 100,
                          ),
                          Text(
                            "EduMate",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            "Admin Panel",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Stats Section
              Padding(
                padding: const EdgeInsets.all(10),
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
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Number Of Students",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF282845),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: NumberOfStudents(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Number Of Teachers",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF282845),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: NumberOfTeachers(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Buttons Section
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Paymentscreen()),
                      ),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A2AE0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Class fee",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Manageschedules()),
                      ),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A2AE0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Schedule Classes",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom Navigation Section
              
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF080B2E),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Managestudents()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage("assets/images/student.png"),
                                width: 24,
                                height: 24,
                              ),
                              Text(
                                "Student",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Manageteachers()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage("assets/images/teacher.png"),
                                width: 24,
                                height: 24,
                              ),
                              Text(
                                "Teachers",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportGenerate()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage("assets/images/report.png"),
                                width: 24,
                                height: 24,
                              ),
                              Text(
                                "Reports",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
