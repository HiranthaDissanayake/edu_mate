import 'package:edu_mate/Admin/SetSchedule.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Registerteacher extends StatefulWidget {
  const Registerteacher({super.key});

  @override
  State<Registerteacher> createState() => _RegisterteacherState();
}

class _RegisterteacherState extends State<Registerteacher> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _genderController = TextEditingController();
  final _gradeController = TextEditingController();
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 2, 1, 95),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(
                    image: AssetImage("asssets/images/AppLogo.png"),
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
                                fillColor:
                                    const Color.fromARGB(255, 36, 36, 63),
                                labelText: "Full Name",
                                labelStyle: TextStyle(color: Colors.white),
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
                                fillColor:
                                    const Color.fromARGB(255, 36, 36, 63),
                                labelText: "Date Of Birth",
                                labelStyle: TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            firstDate: DateTime(2004),
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
                                          style: TextStyle(color: Colors.white),
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
                                fillColor:
                                    const Color.fromARGB(255, 36, 36, 63),
                                labelText: "Gender",
                                labelStyle: TextStyle(color: Colors.white),
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
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _gradeController.text = value!;
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
                                fillColor:
                                    const Color.fromARGB(255, 36, 36, 63),
                                labelText: "Subject",
                                labelStyle: TextStyle(color: Colors.white),
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
                                padding:
                                    const EdgeInsets.only(left: 30, top: 15),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text(
                                        "Grade 6",
                                        style: TextStyle(color: Colors.white),
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
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text(
                                        "Grade 7",
                                        style: TextStyle(color: Colors.white),
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
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text(
                                        "Grade 8",
                                        style: TextStyle(color: Colors.white),
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
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text(
                                        "Grade 9",
                                        style: TextStyle(color: Colors.white),
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
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text(
                                        "Grade 10",
                                        style: TextStyle(color: Colors.white),
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
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text(
                                        "Grade 11",
                                        style: TextStyle(color: Colors.white),
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
                                fillColor:
                                    const Color.fromARGB(255, 36, 36, 63),
                                labelText: "Education Qualifications",
                                labelStyle: TextStyle(color: Colors.white),
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
                                fillColor:
                                    const Color.fromARGB(255, 36, 36, 63),
                                labelText: "Contact No.",
                                labelStyle: TextStyle(color: Colors.white),
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
                                fillColor:
                                    const Color.fromARGB(255, 36, 36, 63),
                                labelText: "Email",
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: GestureDetector(
                              onTap: () {
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();

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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Setschedule(Grade: Grades)));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromARGB(255, 68, 51, 180),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius:
                                              BorderSide.strokeAlignCenter,
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
      ),
    );
  }
}
