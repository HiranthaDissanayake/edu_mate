import 'package:flutter/material.dart';

class Termsandconditions extends StatefulWidget {
  const Termsandconditions({super.key});

  @override
  State<Termsandconditions> createState() => _TermsandconditionsState();
}

class _TermsandconditionsState extends State<Termsandconditions> {
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
      ),
    );
  }
}