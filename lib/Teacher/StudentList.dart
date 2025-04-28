import 'package:edu_mate/Teacher/components/add_marks_button.dart';
import 'package:edu_mate/Teacher/components/edit_marks_button.dart';
import 'package:flutter/material.dart';
import 'package:edu_mate/service/database_methods.dart';

class StudentList extends StatefulWidget {
  
  final String teacherID;
  final String grade;
  
  const StudentList({
    super.key,
    required this.teacherID,
    required this.grade
      });


  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  List<Map<String, dynamic>> students = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudents(widget.grade);
  }

  void fetchStudents(String grade) async {
    List<Map<String, dynamic>> studentData =
        await DatabaseMethods().getAllStudents(grade);
    setState(() {
      students = studentData;
      isLoading = false;
    });
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
                      'Add Marks',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    Text("      "),
                  ],
                ),
              ),
            ),
            Expanded(
              child: students.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : students.isEmpty
                  ? Center(
                    child: Text(
                      'No students found',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                      ),
                    ),
                  )
                  : ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        var student = students[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 27, 32, 85).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12,right: 5),
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: ClipOval(
                                      child: Image.network(
                                        student.containsKey('profileImage') &&
                                                student['profileImage']
                                                    .isNotEmpty
                                            ? student['profileImage']
                                            : 'https://drive.google.com/uc?export=view&id=1cogzIZVFFQMgVfr8emlld-PclxPUzqpv', // Fallback URL
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.network(
                                            'https://drive.google.com/uc?export=view&id=1cogzIZVFFQMgVfr8emlld-PclxPUzqpv', // Fallback image
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  width: 220,
                                  // decoration: BoxDecoration(
                                  //     // color: Color(0xFF26284A),
                                  //     borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          student['Name'] ?? "No Name",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Times New Roman',
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Student ID: ${student['id']}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AddMarksButton(text: "Add Marks", color: Color.fromARGB(255, 41, 42, 65), teacherID: widget.teacherID, studentID: student['id']),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      EditMarksButton(text: "Edit Marks", color: Color.fromARGB(255, 8, 12, 80), teacherID: widget.teacherID, studentID: student['id'],),
                                    ],
                                  ),
                                ),
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
