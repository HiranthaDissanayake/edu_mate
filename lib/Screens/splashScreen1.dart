import 'dart:async';

import 'package:edu_mate/Admin/admin_home_page.dart';
import 'package:edu_mate/Screens/before_login_screen.dart';
import 'package:edu_mate/Student/Student_main_page.dart';
import 'package:edu_mate/Teacher/teacher_dashboard.dart';
import 'package:edu_mate/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Splashscreen1 extends StatefulWidget {
  const Splashscreen1({super.key});

  @override
  _Splashscreen1State createState() => _Splashscreen1State();
}

class _Splashscreen1State extends State<Splashscreen1> {
  String finalEmail = "";
  String finalRole = "";
  String finalPassword = "";

  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() async {
      print("Email: $finalEmail, Role: $finalRole, Password: $finalPassword");
      Timer(Duration(seconds: 3), () async {
        bool? valiedUser =
            await AuthService().loginUser(finalEmail, finalPassword);

        if (finalRole == "admin" && valiedUser) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Adminhomepage()));
        } else if (finalRole == "student" && valiedUser) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => StudentMainPage(stEmail: finalEmail)));
        } else if (finalRole == "teacher" && valiedUser) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Teacherdashboard(grade: "")));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Beforeloginscreen()));
        }
      });
    });
  }

  Future getValidationData() async {
    final storage = FlutterSecureStorage();
    var obtainEmail = await storage.read(key: "email");
    var obtainRole = await storage.read(key: "role");
    var obtainPassword = await storage.read(key: "password");

    setState(() {
      finalEmail = obtainEmail ?? "";
      finalRole = obtainRole ?? "";
      finalPassword = obtainPassword ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
