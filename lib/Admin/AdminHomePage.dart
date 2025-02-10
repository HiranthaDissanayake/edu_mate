import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Adminhomepage extends StatefulWidget {
  const Adminhomepage({super.key});

  @override
  State<Adminhomepage> createState() => _AdminhomepageState();
}

class _AdminhomepageState extends State<Adminhomepage> {
  // ignore: non_constant_identifier_names
  int NumberOfStudents = 320;
  // ignore: non_constant_identifier_names
  int NumberOfTeachers = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 2, 3, 87),
                const Color.fromARGB(255, 18, 52, 126)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 15, 12, 66),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            Image(
                                image:
                                    AssetImage("assets/images/AppLogo.png")),
                            Text(
                              "EduMate",
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 22),
                            ),Text(
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
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 7, 6, 57),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        )]),
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
                                    color:
                                        const Color.fromARGB(255, 30, 27, 94),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: Text("$NumberOfStudents",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                      )),
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
                                  "Total Number Of Students",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 30, 27, 94),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: Text("$NumberOfTeachers",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                      )),
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
                      color: const Color.fromARGB(255, 70, 55, 169),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Generate Report",
                      style:
                          GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 14, 8, 49),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //type the code
                            },
                            child: Container(
                              height: 60,
                              width: 50,
                              child: Column(
                                children: [
                                  Image(image: AssetImage("assets/images/student.png"),
                                  width: 40,
                                  height: 40,
                                  ),
                                  Text("Student",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 10,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,),
                          GestureDetector(
                            onTap: () {
                              //type the code
                            },
                            child: Container(
                              height: 60,
                              width: 50,
                              child: Column(
                                children: [
                                  Image(image: AssetImage("assets/images/teacher.png"),
                                  width: 40,
                                  height: 40,
                                  ),
                                  Text("Teachers",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 10,
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                    )
                ),
              )
            ],
          ),
        ));
  }
}
