import 'package:edu_mate/Teacher/TeacherDashboard.dart';
import 'package:flutter/material.dart';

class Selectclass extends StatefulWidget {
  const Selectclass({super.key});

  @override
  State<Selectclass> createState() => _SelectclassState();
}

class _SelectclassState extends State<Selectclass> {

  // String? selectedSubject;
  String? selectedGrade;

  final List<String> grades = ['Grade 6', 'Grade 7', 'Grade 8', 'Grade 9', 'Grade 10'];
  
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
              SizedBox(
                height: 100,
              ), 
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, bottom: 100),
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
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                  
                      Padding(
                        padding: const EdgeInsets.only(top: 20 ,left: 40, right: 40, bottom: 80),
                        child: Column(
                          children: [
                            // _buildDropdown('Subject', subjects, selectedSubject, (value) {
                            //   setState(() {
                            //     selectedSubject = value;
                            //   });
                            // }),
                             SizedBox(
                              height: 40,
                             ),                    
                            _buildDropdown('Grade', grades, selectedGrade, (value) {
                              setState(() {
                                selectedGrade = value;
                              });
                            }),
                          ],
                        ),
                      ),
                     
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Teacherdashboard(
                              Grade: selectedGrade.toString(),
                            )),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFF3A2AE0),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: 
                            Center(
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

  Widget _buildDropdown(String hint, List<String> items, String? selectedValue, Function(String?) onChanged) {
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