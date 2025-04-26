import 'package:flutter/material.dart';
import 'package:edu_mate/Teacher/teacher_dashboard.dart';
import 'package:edu_mate/service/database.dart'; // Import database.dart

class Selectclass extends StatefulWidget {
  final String teacherID;

  const Selectclass({required this.teacherID, super.key});

  @override
  State<Selectclass> createState() => _SelectclassState();
}

class _SelectclassState extends State<Selectclass> {
  String? selectedGrade;
  List<String> grades = [];
  final DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  void initState() {
    super.initState();
    fetchGrades();
  }

  Future<void> fetchGrades() async {
    List<String> fetchedGrades =
        await DatabaseMethods().fetchGrades(widget.teacherID);
    setState(() {
      grades = fetchedGrades;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C2C88), Color(0xFF0B0B22)],
            stops: [0.17, 0.4],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/AppLogo.png',
                height: 70,
              ),
              const SizedBox(height: 5),
              const Text(
                'EduMate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 100),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Container(
                  height: 450,
                  decoration: BoxDecoration(
                    color: Color(0xFF1E2530).withOpacity(0.75),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Select Class',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 40, right: 40, bottom: 80),
                        child: Column(
                          children: [
                            grades.isEmpty
                                ? CircularProgressIndicator()
                                : _buildDropdown('Grade', grades, selectedGrade,
                                    (value) {
                                    setState(() {
                                      selectedGrade = value;
                                    });
                                  }),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        child: GestureDetector(
                          onTap: () {
                            if (selectedGrade != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Teacherdashboard(
                                    grade: selectedGrade!,
                                  ),
                                ),
                              );
                            } else {
                              print("Please select a grade before proceeding.");
                            }
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFF3A2AE0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Go to the Dashboard',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
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

  Widget _buildDropdown(String hint, List<String> items, String? selectedValue,
      Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xFF28313F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint, style: TextStyle(color: Colors.white70)),
          value: selectedValue,
          isExpanded: true,
          dropdownColor: Colors.grey[900],
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          onChanged: onChanged,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
