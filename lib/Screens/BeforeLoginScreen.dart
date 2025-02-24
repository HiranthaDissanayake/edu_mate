import 'package:edu_mate/Admin/AdminHomePage.dart';
import 'package:edu_mate/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class Beforeloginscreen extends StatefulWidget {
  const Beforeloginscreen({super.key});

  @override
  State<Beforeloginscreen> createState() => _BeforeloginscreenState();
}

class _BeforeloginscreenState extends State<Beforeloginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Loginscreen(role: "admin")));}, child: Text("Login"),),
      ),  
    );
  }
}