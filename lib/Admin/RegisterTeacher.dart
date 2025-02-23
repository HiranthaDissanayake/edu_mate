import 'package:edu_mate/Admin/SetSchedule.dart';
import 'package:edu_mate/service/auth_service.dart';
import 'package:edu_mate/service/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class Registerteacher extends StatefulWidget {
  const Registerteacher({super.key});

  @override
  State<Registerteacher> createState() => _RegisterteacherState();
}

class _RegisterteacherState extends State<Registerteacher> {
  final _auth = AuthService();

  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _genderController = TextEditingController();
  final _subjectController = TextEditingController();
  final _emailController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _grade6 = false;
  bool _grade7 = false;
  bool _grade8 = false;
  bool _grade9 = false;
  bool _grade10 = false;
  bool _grade11 = false;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF13134C),
              Color(0xFF13134C),
              Color(0xFF2D2DB2),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF010127),
                      Color(0xFF010127),
                      Color(0xFF0B0C61),
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                        topRight: Radius.circular(150))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          iconSize: 30,
                        ),
                      ),
                      SizedBox(
                        width: 320,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  height: 700,
                  decoration: BoxDecoration(
                    color: const Color(0xFF181A47),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage("assets/images/AppLogo.png"),
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          "REGISTER TEACHER",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Form(
                          key: _formkey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: TextFormField(
                                    controller: _nameController,
                                    style: TextStyle(color: Colors.white),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Your Name";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 13, 0, 253)),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF28313F),
                                      labelText: "Full Name",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    controller: _dateController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Your Date of Birth";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 13, 0, 253)),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF28313F),
                                      labelText: "Date Of Birth",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          showDatePicker(
                                                  context: context,
                                                  firstDate: DateTime(1950),
                                                  lastDate: DateTime.now())
                                              .then((value) {
                                            setState(() {
                                              _dateController.text =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(value!);
                                            });
                                          });
                                        },
                                        color: Colors.white,
                                        icon: Icon(Icons.calendar_month),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: DropdownButtonFormField<String>(
                                    value: null,
                                    items: ['Male', 'Female']
                                        .map((String value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _genderController.text = value!;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return "Please Select Your Gender";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 13, 0, 253)),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF28313F),
                                      labelText: "Gender",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                    dropdownColor:
                                        const Color.fromARGB(255, 36, 36, 63),
                                    borderRadius: BorderRadius.circular(10),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: DropdownButtonFormField<String>(
                                    value: null,
                                    items: [
                                      'Mathematics',
                                      'Science',
                                      'English',
                                      'History',
                                      'Sinhala',
                                      'Commerce'
                                    ]
                                        .map((String value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _subjectController.text = value!;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return "Please Select Your subject";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 13, 0, 253)),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF28313F),
                                      labelText: "Subject",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                    dropdownColor:
                                        const Color.fromARGB(255, 36, 36, 63),
                                    borderRadius: BorderRadius.circular(10),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30, top: 15),
                                      child: Text(
                                        "Grades",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              "Grade 6",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            value: _grade6,
                                            activeColor:
                                                Color.fromARGB(255, 13, 0, 253),
                                            onChanged: (value) {
                                              setState(() {
                                                _grade6 = value!;
                                              });
                                            },
                                          ),
                                          CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              "Grade 7",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            value: _grade7,
                                            onChanged: (value) {
                                              setState(() {
                                                _grade7 = value!;
                                              });
                                            },
                                            activeColor:
                                                Color.fromARGB(255, 13, 0, 253),
                                          ),
                                          CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              "Grade 8",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            value: _grade8,
                                            onChanged: (value) {
                                              setState(() {
                                                _grade8 = value!;
                                              });
                                            },
                                            activeColor:
                                                Color.fromARGB(255, 13, 0, 253),
                                          ),
                                          CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              "Grade 9",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            value: _grade9,
                                            onChanged: (value) {
                                              setState(() {
                                                _grade9 = value!;
                                              });
                                            },
                                            activeColor:
                                                Color.fromARGB(255, 13, 0, 253),
                                          ),
                                          CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              "Grade 10",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            value: _grade10,
                                            onChanged: (value) {
                                              setState(() {
                                                _grade10 = value!;
                                              });
                                            },
                                            activeColor:
                                                Color.fromARGB(255, 13, 0, 253),
                                          ),
                                          CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              "Grade 11",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            value: _grade11,
                                            onChanged: (value) {
                                              setState(() {
                                                _grade11 = value!;
                                              });
                                            },
                                            activeColor:
                                                Color.fromARGB(255, 13, 0, 253),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: TextFormField(
                                    controller: _qualificationController,
                                    style: TextStyle(color: Colors.white),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Your Qualifications";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 13, 0, 253)),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF28313F),
                                      labelText: "Education Qualifications",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: _phoneController,
                                    style: TextStyle(color: Colors.white),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Your Contact Number";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 13, 0, 253)),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF28313F),
                                      labelText: "Contact No.",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: TextFormField(
                                    controller: _emailController,
                                    style: TextStyle(color: Colors.white),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Your Email";
                                      }
                                      if (!value.contains("@gmail.com")) {
                                        return "Please Enter a Valid Email";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 13, 0, 253)),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF28313F),
                                      labelText: "Email",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40),
                                Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (_formkey.currentState!.validate()) {
                                        String id = randomAlphaNumeric(10);
                                        List<String> Grades = [];
                                        if (_grade6) {
                                          Grades.add("Grade 6");
                                        }
                                        if (_grade7) {
                                          Grades.add("Grade 7");
                                        }
                                        if (_grade8) {
                                          Grades.add('Grade 8');
                                        }
                                        if (_grade9) {
                                          Grades.add("Grade 9");
                                        }
                                        if (_grade10) {
                                          Grades.add("Grade 10");
                                        }
                                        if (_grade11) {
                                          Grades.add("Grade 11");
                                        }
                                        Map<String, dynamic> teacherInfoMap = {
                                          "TeacherId": id,
                                          "Name": _nameController.text,
                                          "DateOfBirth": _dateController.text,
                                          "Gender": _genderController.text,
                                          "Subject": _subjectController.text,
                                          "Grade": Grades,
                                          "Quelification":
                                              _qualificationController.text,
                                          "ContactNo": _phoneController.text,
                                          "Email": _emailController.text
                                        };
                                        Map<String, dynamic> scheduleInfoMap = {
                                          "TeacherId": id,
                                          "Subject": _subjectController.text
                                        };
                                        await DatabaseMethods()
                                            .addTeacherDetails(
                                                teacherInfoMap, id);
                                        await DatabaseMethods().setTeacherRole(
                                            id, _emailController.text);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Teacher Registered Succesfully")));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Setschedule(
                                                        Grade: Grades,
                                                        scheduleInfoMap:
                                                            scheduleInfoMap)));

                                        setState(() {
                                          _nameController.clear();
                                          _dateController.clear();
                                          _genderController.clear();
                                          _subjectController.clear();
                                          _qualificationController.clear();
                                          _phoneController.clear();
                                          _emailController.clear();
                                          _grade6 = false;
                                          _grade7 = false;
                                          _grade8 = false;
                                          _grade9 = false;
                                          _grade10 = false;
                                          _grade11 = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xFF3A2AE0),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: BorderSide
                                                    .strokeAlignCenter,
                                                color: Colors.white)
                                          ]),
                                      height: 50,
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          "Submit",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
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
