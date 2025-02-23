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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Before Login Screen"),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginscreen(role: "admin",)));
          }, child: Text("Admin"))
        ],
      ),
    );
  }
}