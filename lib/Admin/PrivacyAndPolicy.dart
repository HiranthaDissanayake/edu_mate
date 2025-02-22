import 'package:edu_mate/service/database.dart';
import 'package:flutter/material.dart';

class Privacyandpolicy extends StatefulWidget {
  const Privacyandpolicy({super.key});

  @override
  State<Privacyandpolicy> createState() => _PrivacyandpolicyState();
}

class _PrivacyandpolicyState extends State<Privacyandpolicy> {
  late List<String> privacyStream = [];

  Future<void> getonetheload() async {
    try {
      privacyStream = await DatabaseMethods().fetchPrivacyPolicy();
      setState(() {});
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getonetheload();
  }

  Widget privacyPolicy() => Text(
    privacyStream.join('\n\n'),
    style: TextStyle(color: Colors.white),
  );

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF13134C),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
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
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF13134C),
            ),
            child: Container(
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  Text(
                    "Privacy and Policy",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      width: 300,
                      height: 700,
                      child: Expanded(child: privacyPolicy(),
                      )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}