import 'package:edu_mate/Admin/AdminHomePage.dart';
import 'package:edu_mate/Student/Student_main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:edu_mate/Teacher/LoginScreen.dart';
import 'package:edu_mate/Admin/ManageStudents.dart';
import 'package:edu_mate/Teacher/Attendance.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StudentMainPage(),
    );
  }
}
