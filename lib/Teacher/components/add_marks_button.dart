import 'package:flutter/material.dart';
import 'package:edu_mate/service/database_methods.dart';

class AddMarksButton extends StatefulWidget {
  String text;
  Color color;
  final String teacherID;
  final String studentID;

  AddMarksButton({
    super.key,
    required this.text,
    required this.color,
    required this.teacherID,
    required this.studentID,
  
  });

  @override
  State<AddMarksButton> createState() => _AddMarksButtonState();
}

class _AddMarksButtonState extends State<AddMarksButton> {
  // Controllers for adding marks
  late TextEditingController studentIdController;
  final TextEditingController testNoController = TextEditingController();
  final TextEditingController marksController = TextEditingController();

   @override
     void initState() {
    super.initState();
    // Initialize the student ID controller with the provided student ID
    studentIdController = TextEditingController(text: widget.studentID);
  }

  void submitMarks() async {
    String studentId = studentIdController.text.trim();
    String testNo = testNoController.text.trim();
    String marks = marksController.text.trim();

    if (studentId.isNotEmpty && testNo.isNotEmpty && marks.isNotEmpty) {
      await DatabaseMethods()
          .addStudentMarks(studentId, widget.teacherID, testNo, marks);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Marks added successfully!")));

      testNoController.clear();
      marksController.clear();
      
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All fields are required")));
    }

    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 110,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Color.fromARGB(255, 21, 21, 22),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: Text(widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),),
                content: SizedBox(
                  height: 320,
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 7,
                      ),
                      TextField(
                        controller: studentIdController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Student ID',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                        style: TextStyle(color: const Color.fromARGB(255, 171, 171, 171)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextField(
                        controller: testNoController,
                        decoration: InputDecoration(
                          labelText: 'Test No.',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15)
                          ),
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
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                       SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: SizedBox(
                          height: 45,
                          width: 300,
                          child: ElevatedButton(
                              onPressed: submitMarks,
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 65, 65, 107),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
                // actions: [
                //   TextButton(
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                //     child: Text('Close',
                //     style: TextStyle(color: Colors.white),),
                //   ),
                // ],
              );
            },
          );
        },
        child: Text(
          widget.text,
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          // minimumSize: Size(60, 30),
        ),
      ),
    );
  }
}
