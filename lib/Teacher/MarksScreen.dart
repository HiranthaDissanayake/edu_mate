import 'package:edu_mate/Teacher/TeacherDashboard.dart';
import 'package:flutter/material.dart';
import 'package:edu_mate/service/database.dart';

class Marksscreen extends StatefulWidget {
  const Marksscreen({super.key});

  @override
  State<Marksscreen> createState() => _MarksscreenState();
}

class _MarksscreenState extends State<Marksscreen> {

  //controllers for add marks
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController testNoController = TextEditingController();
  final TextEditingController marksController = TextEditingController();
  
  //controllers for edit marks
  final TextEditingController editStudentIdController = TextEditingController();
  final TextEditingController editTestNoController = TextEditingController();
  final TextEditingController newMarksController = TextEditingController();


  void submitMarks() async {
    String studentId = studentIdController.text.trim();
    String testNo = testNoController.text.trim();
    String marks = marksController.text.trim();

    if (studentId.isNotEmpty && testNo.isNotEmpty && marks.isNotEmpty) {
      await DatabaseMethods().addStudentMarks(studentId, testNo, marks);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Marks added successfully!"))
      );

      // Clear the input fields after submission
      studentIdController.clear();
      testNoController.clear();
      marksController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields are required"))
      );
    }
  }

  void updateMarks() async {
  String studentId = editStudentIdController.text.trim();
  String testNo = editTestNoController.text.trim();
  String newMarks = newMarksController.text.trim();

  if (studentId.isNotEmpty && testNo.isNotEmpty && newMarks.isNotEmpty) {
    await DatabaseMethods().editStudentMarks(studentId, testNo, newMarks);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Marks updated successfully!"))
    );

    // Clear input fields after submission
    studentIdController.clear();
    testNoController.clear();
    newMarksController.clear();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("All fields are required"))
    );
  }
}



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
                              // Text(
                              //   'Student ID',
                              //   style: TextStyle(
                              //     color: Colors.white,
                              //   ),
                              // ),
                              SizedBox(
                                height: 7,
                              ),
                              TextField(
                                controller: studentIdController,
                                decoration: InputDecoration(
                                  labelText: 'Student ID',
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextField(
                                controller: testNoController,
                                decoration: InputDecoration(
                                  labelText: 'Test No.',
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 25,
                              ), 
                              TextField(
                                controller: marksController,
                                decoration: InputDecoration(
                                  labelText: 'Marks Obtained',
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(color: Colors.white),
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
                              onPressed: submitMarks,
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
                               TextField(
                                  controller: editStudentIdController,
                                  decoration: InputDecoration(
                                    labelText: "Student ID",
                                    border: OutlineInputBorder(),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                              SizedBox(
                                height: 25,
                              ),
                              TextField(
                                controller: editTestNoController,
                                decoration: InputDecoration(
                                  labelText: "Test No.",
                                  border: OutlineInputBorder(),
                                ),
                                 
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                               TextField(
                                  controller: newMarksController,
                                  decoration: InputDecoration(
                                    labelText: "New Marks",
                                    border: OutlineInputBorder(),
                                  ),
                                  style: TextStyle(color: Colors.white),
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
                              onPressed: updateMarks,
                              child: Text(
                                'Update Marks',
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
