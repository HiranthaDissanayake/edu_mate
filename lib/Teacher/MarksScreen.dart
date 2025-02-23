import 'package:edu_mate/Teacher/TeacherDashboard.dart';
import 'package:flutter/material.dart';

class Marksscreen extends StatefulWidget {
  const Marksscreen({super.key});

  @override
  State<Marksscreen> createState() => _MarksscreenState();
}

class _MarksscreenState extends State<Marksscreen> {
  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(65),
                      topRight: Radius.circular(125)),
                  gradient: LinearGradient(
                    colors: [Color(0xFF010127), Color(0xFF0B0C61)],
                    // stops: [0.5,0.5],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                // color: const Color.fromARGB(255, 45, 2, 131),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Teacherdashboard(
                            Grade: '',
                          )),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Marks",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Text("               "),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(35),
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(8, 11, 146, 100),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 18),
                        child: Container(
                          height: 35,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Color(0xFF26284A),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Add Marks",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 50, right: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Student ID',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    fillColor: Color(0xFF26284A),
                                    filled: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Test No.',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    fillColor: Color(0xFF26284A),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    filled: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Marks Obtained',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    fillColor: Color(0xFF26284A),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          height: 35,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff3A2AE0),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(8, 11, 146, 100),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 18),
                        child: Container(
                          height: 35,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Color(0xFF26284A),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Edit Marks",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 50, right: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Student ID',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    fillColor: Color(0xFF26284A),
                                    filled: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Test No.',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    fillColor: Color(0xFF26284A),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    filled: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'New Marks',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    fillColor: Color(0xFF26284A),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          height: 35,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff3A2AE0),
                              )),
                        ),
                      ),
                    ],
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
