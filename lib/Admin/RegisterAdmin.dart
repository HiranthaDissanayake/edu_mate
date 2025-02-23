import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/service/auth_service.dart';
import 'package:edu_mate/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
class Registeradmin extends StatefulWidget {
  const Registeradmin({super.key});

  @override
  State<Registeradmin> createState() => _RegisteradminState();
}

class _RegisteradminState extends State<Registeradmin> {
  final _auth = AuthService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                    color: Color(0xFF181A47),
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
                          "REGISTER ADMIN",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Your Name";
                                      }
                                      return null;
                                    },
                                    controller: _nameController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 13, 0, 253),
                                        ),
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
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Your designation";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                    controller: _designationController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 13, 0, 253),
                                        ),
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
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please password";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                    controller: _passwordController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 13, 0, 253),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF28313F),
                                      labelText: "paswsword",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Email";
                                      }
                                      if (!value.contains("@gmail.com")) {
                                        return "Please Enter Valid Email";
                                      }
                                      return null;
                                    },
                                    controller: _emailController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 13, 0, 253),
                                        ),
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
                                      String id = randomAlphaNumeric(10);
                                      if (_formKey.currentState!.validate()) {

                                        await DatabaseMethods().setAdminRole(_passwordController.text, _emailController.text);

                                        Map<String, dynamic> adminInfoMap = {
                                          "AdminID": id,
                                          "Name": _nameController.text,
                                          "Designation": _designationController.text,
                                          "role": "admin",
                                          "Email": _emailController.text,
                                        };

                                        await DatabaseMethods()
                                            .addAdminDetails(
                                                adminInfoMap, id);

                                        Fluttertoast.showToast(
                                          msg:
                                              "Admin Registered Successfully",
                                          gravity: ToastGravity.CENTER,
                                          textColor: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          backgroundColor: Colors.green,
                                          fontSize: 20,
                                        );

                                        setState(() {
                                          _nameController.clear();
                                          _emailController.clear();
                                          _passwordController.clear();
                                          _designationController.clear();
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            255, 68, 51, 180),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF3A2AE0),
                                          )
                                        ],
                                      ),
                                      height: 50,
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          "Submit",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
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
