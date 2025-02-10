import 'package:flutter/material.dart';

class Adminhomepage extends StatefulWidget {
  const Adminhomepage({super.key});

  @override
  State<Adminhomepage> createState() => _AdminhomepageState();
}

class _AdminhomepageState extends State<Adminhomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Admin Home Page")),
    );
  }
}