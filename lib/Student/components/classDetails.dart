import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Classdetails extends StatelessWidget {
  final String title;
  final dynamic data;

  const Classdetails({
    super.key,
    required this.title,
    required this.data,
    });

  

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Text(title ,style: GoogleFonts.poppins( color: title == "Date" ? Color(0xFFB2383A): title == "Time" ? Color(0xFFB2383A) : title == "Teacher"? Color(0xFF5342FF) : Colors.white,fontSize: 15, fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Text(data.toString(),style: GoogleFonts.poppins(color: data == "Maths" ? Color(0xFF308FAF) : Colors.white,fontSize: 15, fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }
}