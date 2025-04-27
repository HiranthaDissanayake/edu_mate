import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/service/app_logger.dart';
import 'package:flutter/material.dart';

class Updateschedulescreen extends StatefulWidget {
  final String scheduleId;
  final String teacherId;

  const Updateschedulescreen(
      {super.key, required this.scheduleId, required this.teacherId});

  @override
  State<Updateschedulescreen> createState() => _Updateschedulescreen();
}

class _Updateschedulescreen extends State<Updateschedulescreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController teacherIdController;
  late TextEditingController teacherNameController;
  late TextEditingController subjectController;
  late TextEditingController classFeeController;

  String selectedGrade = "Grade 6";
  String selectedClassDay = "Monday";
  String startTime = "Select Start Time";
  String endTime = "Select End Time";

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
    fetchSchedule();
    teacherIdController = TextEditingController();
    teacherNameController = TextEditingController();
    subjectController = TextEditingController();
    classFeeController = TextEditingController();
  }

  @override
  void dispose() {
    teacherIdController.dispose();
    teacherNameController.dispose();
    subjectController.dispose();
    classFeeController.dispose();
    super.dispose();
  }

  Future<void> fetchSchedule() async {
    try {
      DocumentSnapshot scheduleDoc = await FirebaseFirestore.instance
          .collection('Schedules')
          .doc(widget.scheduleId)
          .get();

      if (scheduleDoc.exists) {
        Map<String, dynamic> data = scheduleDoc.data() as Map<String, dynamic>;
        setState(() {
          teacherIdController.text = data["TeacherId"] ?? '';
          subjectController.text = data["Subject"] ?? '';
          selectedGrade = data["Grade"] ?? "Grade 6";
          selectedClassDay = data["ClassDay"] ?? "Monday";
          startTime = data["StartTime"] ?? "Select Start Time";
          endTime = data["EndTime"] ?? "Select End Time";
          classFeeController.text = data["ClassFee"] ?? "Enter class fee";
        });
      }

      if (teacherIdController.text.isNotEmpty) {
        DocumentSnapshot teacherDoc = await FirebaseFirestore.instance
            .collection('Teachers')
            .doc(teacherIdController.text)
            .get();

        if (teacherDoc.exists) {
          setState(() {
            teacherNameController.text =
                teacherDoc["Name"] ?? 'Unknown Teacher';
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching schedule: $e")),
      );
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? _parseTime(startTime) ?? TimeOfDay.now()
          : _parseTime(endTime) ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        String formattedTime = pickedTime.format(context);
        if (isStartTime) {
          startTime = formattedTime;
        } else {
          endTime = formattedTime;
        }
      });
    }
  }

  TimeOfDay? _parseTime(String timeString) {
    try {
      final format = RegExp(r'(\d+):(\d+) (AM|PM)');
      final match = format.firstMatch(timeString);
      if (match != null) {
        int hour = int.parse(match.group(1)!);
        int minute = int.parse(match.group(2)!);
        String period = match.group(3)!;

        if (period == "PM" && hour != 12) hour += 12;
        if (period == "AM" && hour == 12) hour = 0;

        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (e) {
      AppLogger().e("Error parsing time: $e");
    }
    return null;
  }

  void _updateSchedule() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('Schedules')
            .doc(widget.scheduleId)
            .update({
          "TeacherId": teacherIdController.text,
          "Subject": subjectController.text,
          "Grade": selectedGrade,
          "ClassDay": selectedClassDay,
          "StartTime": startTime,
          "EndTime": endTime,
          "ClassFee": classFeeController.text,
        });

        await FirebaseFirestore.instance
            .collection('Teachers')
            .doc(widget.teacherId)
            .update({
          "Name": teacherNameController.text,
        });
      
      if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Schedule updated successfully!")),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating schedule: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF13134C), Color(0xFF2D2DB2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
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
                        "Edit Schedule",
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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            enabled: false,
                            controller: teacherIdController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: "Teacher ID",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextFormField(
                            enabled: false,
                            controller: teacherNameController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: "Teacher Name",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextFormField(
                            enabled: false,
                            controller: subjectController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: "Subject",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? "Enter Subject" : null,
                          ),

                          // Grades dropdown
                          DropdownButtonFormField(
                            value: selectedGrade,
                            dropdownColor: Colors.blueGrey,
                            decoration: const InputDecoration(
                              labelText: "Grade",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            items: grades.map((grade) {
                              return DropdownMenuItem(
                                value: grade,
                                child: Text(grade,
                                    style: TextStyle(color: Colors.white)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedGrade = value!;
                              });
                            },
                          ),

                          // Day dropdown
                          DropdownButtonFormField(
                            value: selectedClassDay,
                            dropdownColor: Colors.blueGrey,
                            decoration: const InputDecoration(
                              labelText: "Class Day",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            items: classDays.map((day) {
                              return DropdownMenuItem(
                                value: day,
                                child: Text(day,
                                    style: TextStyle(color: Colors.white)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedClassDay = value!;
                              });
                            },
                          ),

                          // Start time selector
                          ListTile(
                            leading: Text(
                              "Start Time",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            title: Text(startTime,
                                style: TextStyle(color: Colors.white)),
                            trailing:
                                Icon(Icons.access_time, color: Colors.white),
                            onTap: () => _selectTime(context, true),
                          ),

                          // End time selector
                          ListTile(
                            leading: Text("End Time",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            title: Text(endTime,
                                style: TextStyle(color: Colors.white)),
                            trailing:
                                Icon(Icons.access_time, color: Colors.white),
                            onTap: () => _selectTime(context, false),
                          ),

                          // Class fee field
                          TextFormField(
                            controller: classFeeController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: "Class Fee",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? "Enter Class Fee" : null,
                          ),
                          SizedBox(height: 100),
                          ElevatedButton(
                            onPressed: _updateSchedule,
                            child: const Text("Save Changes"),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
