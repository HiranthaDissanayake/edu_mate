import 'dart:async';

import 'package:edu_mate/Admin/admin_home_page.dart';
import 'package:edu_mate/Screens/BeforeLoginScreen.dart';
import 'package:edu_mate/Student/Student_main_page.dart';
import 'package:edu_mate/Teacher/TeacherDashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen1 extends StatefulWidget {
  const Splashscreen1({super.key});

  @override
  _Splashscreen1State createState() => _Splashscreen1State();
}

class _Splashscreen1State extends State<Splashscreen1> {
  String finalEmail = "";
  String finalRole = "";

  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() async {
      Timer(Duration(seconds: 3), () {
        if (finalRole == "admin") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Adminhomepage()));
        } else if (finalRole == "student") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => StudentMainPage(stEmail: finalEmail)));
        } else if (finalRole == "teacher") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Teacherdashboard(Grade: "")));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Beforeloginscreen()));
        }
      });
    });
  }

  Future getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtainEmail = prefs.getString('email');
    var obtainRole = prefs.getString('role');

    setState(() {
      finalEmail = obtainEmail ?? "";
      finalRole = obtainRole ?? "";
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