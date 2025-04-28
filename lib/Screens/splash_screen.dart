import 'dart:async';
import 'package:edu_mate/Admin/admin_home_page.dart';
import 'package:edu_mate/Screens/before_login_screen.dart';
import 'package:edu_mate/Student/student_main_page.dart';
import 'package:edu_mate/Teacher/SelectClass.dart';
import 'package:edu_mate/Teacher/TeacherDashboard.dart';
import 'package:edu_mate/service/app_logger.dart';
import 'package:edu_mate/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  String finalEmail = "";
  String finalRole = "";
  String finalPassword = "";

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  Future<void> startSplashScreen() async {
    await getValidationData();

    AppLogger()
        .d("Email: $finalEmail, Role: $finalRole, Password: $finalPassword");

    bool validUser = false;

    if (finalEmail.isNotEmpty &&
        finalPassword.isNotEmpty &&
        finalRole.isNotEmpty) {
      // User already has data saved - try auto login
      validUser = await AuthService().loginUser(finalEmail, finalPassword);
      AppLogger().d("Attempted auto-login: $validUser");
    } else {
      AppLogger().d("No login data found");
    }

    // Delay splash screen for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    if (validUser) {
      if (finalRole == "admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Adminhomepage()),
        );
      } else if (finalRole == "student") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => StudentMainPage(stEmail: finalEmail)),
        );
      } else if (finalRole == "teacher") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Selectclass(teacherID: finalPassword)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Beforeloginscreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Beforeloginscreen()),
      );
    }
  }

  Future<void> getValidationData() async {
    const storage = FlutterSecureStorage();
    final obtainEmail = await storage.read(key: "email");
    final obtainRole = await storage.read(key: "role");
    final obtainPassword = await storage.read(key: "password");

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
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
