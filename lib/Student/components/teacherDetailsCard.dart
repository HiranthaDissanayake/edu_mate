import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Teacherdetails extends StatelessWidget {
  final String title;
  final dynamic data;

  const Teacherdetails({
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
          padding: const EdgeInsets.only(left: 20,top: 7),
          child: Text(title.toString() ,style: GoogleFonts.poppins(color:  Colors.deepOrange,fontSize: 19, fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 7),
          child: Text(data.toString() ,style: GoogleFonts.poppins(color: Colors.white,fontSize: 19, fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }
}