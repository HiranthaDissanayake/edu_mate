import 'dart:async';

import 'package:edu_mate/Admin/admin_home_page.dart';
import 'package:edu_mate/Screens/before_login_screen.dart';
import 'package:edu_mate/Student/student_main_page.dart';
import 'package:edu_mate/Teacher/teacher_dashboard.dart';
import 'package:edu_mate/service/app_logger.dart';
import 'package:edu_mate/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _Splashscreen1State();
}

class _Splashscreen1State extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  String finalEmail = "";
  String finalRole = "";
  String finalPassword = "";

  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() async {
      AppLogger()
          .d("Email: $finalEmail, Role: $finalRole, Password: $finalPassword");
      Timer(const Duration(seconds: 3), () async {
        bool? valiedUser =
            await AuthService().loginUser(finalEmail, finalPassword);

        if (!mounted) return;

        if (finalRole == "admin" && valiedUser) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Adminhomepage()));
        } else if (finalRole == "student" && valiedUser) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => StudentMainPage(stEmail: finalEmail)));
        } else if (finalRole == "teacher" && valiedUser) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const Teacherdashboard(grade: "")));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const Beforeloginscreen()));
        }
      });
    });
  }

  Future getValidationData() async {
    final storage = const FlutterSecureStorage();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.5, end: 1.0),
              duration: const Duration(seconds: 2),
              curve: Curves.easeOutExpo,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/AppLogo.png',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'EduMate',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
