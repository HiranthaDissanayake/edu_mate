import 'package:flutter/material.dart';

class Attendencecontainer extends StatefulWidget {
  const Attendencecontainer({super.key});

  @override
  State<Attendencecontainer> createState() => _AttendencecontainerState();
}

class _AttendencecontainerState extends State<Attendencecontainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFFB72CBC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(child: Text("Mathematics", style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
    );
  }
}
