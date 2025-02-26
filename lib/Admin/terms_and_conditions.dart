import 'package:edu_mate/service/database.dart';
import 'package:flutter/material.dart';

class Termsandconditions extends StatefulWidget {
  const Termsandconditions({super.key});

  @override
  State<Termsandconditions> createState() => _TermsandconditionsState();
}

class _TermsandconditionsState extends State<Termsandconditions> {
  late List<String> termsStream = [];

  Future<void> getonetheload() async {
    try {
      termsStream = await DatabaseMethods().fetchTermsAndConditions();
      setState(() {});
    } catch (e) {
      print('Error fetching terms and conditions: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getonetheload();
  }

  Widget termsAndConditions() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: termsStream.map((term) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            term,
            style: TextStyle(color: Colors.white),
          ),
        )).toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF13134C),
      ),
      body: Container(
        width: double.infinity,
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF13134C),
            ),
            child: Column(
              children: [
                Text(
                  "Terms and Conditions",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: termsAndConditions(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}