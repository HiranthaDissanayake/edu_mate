import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/service/app_logger.dart';
import 'package:flutter/material.dart';

class CreateNewSchedule extends StatefulWidget {
  const CreateNewSchedule({super.key});

  @override
  State<CreateNewSchedule> createState() => _CreateNewScheduleState();
}

class _CreateNewScheduleState extends State<CreateNewSchedule> {
  final _formKey = GlobalKey<FormState>();

  List<String> teachers = [];
  StreamSubscription<QuerySnapshot>? _teacherStreamSubscription;

  String? selectedName;
  String? selectedSubject;
  String? selectedGrade;
  String? selectedClassDay;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  final TextEditingController _classFeeController = TextEditingController();

  final List<String> subjects = [
    "Math",
    "Science",
    "English",
    "History",
    "Sinhala",
    "Commerce"
  ];
  final List<String> grades = [
    "Grade 6",
    "Grade 7",
    "Grade 8",
    "Grade 9",
    "Grade 10",
    "Grade 11"
  ];
  final List<String> classDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  void initState() {
    super.initState();
    _fetchTeachers();
  }

  void _fetchTeachers() async {
    AppLogger().i("Fetching teachers...");
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("Teachers").get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          teachers = snapshot.docs.map((doc) {
            String id = doc.id; // Use document ID
            String name = doc['Name'] ?? 'N/A';
            String subject = doc['Subject'] ?? 'N/A';
            return "$id|$name|$subject";
          }).toList();
        });
      } else {
        AppLogger().w("No teachers found in Firestore.");
      }
    } catch (error) {
      AppLogger().e("Error fetching teachers: $error");
    }
  }

  @override
  void dispose() {
    _teacherStreamSubscription?.cancel(); // Dispose of the stream
    super.dispose();
  }

  void _addNewSchedule() async {
    if (_formKey.currentState!.validate()) {
      if (selectedName == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Please select a teacher!")));
        return;
      }

      try {
        List<String> teacherInfo = selectedName!.split('|');
        String teacherId = teacherInfo[0];

        // Prepare schedule data
        Map<String, dynamic> newSchedule = {
          "TeacherId": teacherId,
          "Subject": selectedSubject ?? "N/A",
          "Grade": selectedGrade ?? "N/A",
          "ClassDay": selectedClassDay ?? "N/A",
          "StartTime": startTime != null
              ? "${startTime!.hour}:${startTime!.minute}"
              : null,
          "EndTime":
              endTime != null ? "${endTime!.hour}:${endTime!.minute}" : null,
          "ClassFee": _classFeeController.text.trim(),
        };

        // Add to Firestore in the 'Schedules' collection
        await FirebaseFirestore.instance
            .collection("Schedules")
            .add(newSchedule);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Schedule added successfully!")));

        // Reset form after successful submission
        setState(() {
          selectedName = null;
          selectedSubject = null;
          selectedGrade = null;
          selectedClassDay = null;
          startTime = null;
          endTime = null;
          _classFeeController.clear();
        });
      } catch (error) {
        AppLogger().e("Error adding schedule: $error");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed to add schedule!")));
      }
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? (startTime ?? TimeOfDay.now())
          : (endTime ?? TimeOfDay.now()),
    );
    if (picked != null && mounted) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF13134C), Color(0xFF13134C), Color(0XFF2D2DB2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // App Bar
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF010127), Color(0xFF0B0C61)],
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
                      "Add Schedules",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),

            // Form
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: selectedName,
                          dropdownColor: Colors.blueGrey,
                          decoration: _inputDecoration("Select Name"),
                          items: teachers.map((teacher) {
                            return DropdownMenuItem<String>(
                              value: teacher,
                              child: Text(
                                teacher.split('|')[1], // Display teacher name
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => selectedName = value),
                          validator: (value) =>
                              value == null ? "Please select a name" : null,
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedSubject,
                          dropdownColor: Colors.blueGrey,
                          decoration: _inputDecoration("Select Subject"),
                          items: subjects.map((subject) {
                            return DropdownMenuItem(
                              value: subject,
                              child: Text(subject,
                                  style: TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => selectedSubject = value),
                          validator: (value) =>
                              value == null ? "Please select a subject" : null,
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedGrade,
                          dropdownColor: Colors.blueGrey,
                          decoration: _inputDecoration("Select Grade"),
                          items: grades.map((grade) {
                            return DropdownMenuItem(
                              value: grade,
                              child: Text(grade,
                                  style: TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => selectedGrade = value),
                          validator: (value) =>
                              value == null ? "Please select a grade" : null,
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedClassDay,
                          dropdownColor: Colors.blueGrey,
                          decoration: _inputDecoration("Select Class Day"),
                          items: classDays.map((day) {
                            return DropdownMenuItem(
                              value: day,
                              child: Text(day,
                                  style: TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => selectedClassDay = value),
                          validator: (value) => value == null
                              ? "Please select a class day"
                              : null,
                        ),
                        SizedBox(height: 10),
                        _buildTimePicker("Select Start Time", startTime, true),
                        SizedBox(height: 10),
                        _buildTimePicker("Select End Time", endTime, false),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _classFeeController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          decoration: _inputDecoration("Enter Class Fee"),
                          validator: (value) =>
                              value!.isEmpty ? "Please enter class fee" : null,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _addNewSchedule,
                          child: const Text("Save Changes"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      filled: true,
      fillColor: Color(0xFF28133F),
      labelText: label,
      labelStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }

  Widget _buildTimePicker(String label, TimeOfDay? time, bool isStartTime) {
    return InkWell(
      onTap: () => _selectTime(context, isStartTime),
      child: InputDecorator(
        decoration: _inputDecoration(label),
        child: Text(time != null ? time.format(context) : label,
            style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
