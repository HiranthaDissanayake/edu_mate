import 'package:edu_mate/Admin/admin_home_page.dart';
import 'package:edu_mate/Admin/register_teacher.dart';
import 'package:edu_mate/Screens/LoginScreen.dart';
import 'package:edu_mate/Screens/splashScreen1.dart';
import 'package:edu_mate/Student/Student_main_page.dart';
import 'package:edu_mate/Teacher/SelectClass.dart';
import 'package:edu_mate/Teacher/TeacherDashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:edu_mate/Teacher/LoginScreen.dart';
import 'package:edu_mate/Admin/register_student.dart';
import 'package:edu_mate/Teacher/SendAlerts.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MyApp(), // Wrap your app here
  );
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
      home: Splashscreen1(),
    );
  }
}
