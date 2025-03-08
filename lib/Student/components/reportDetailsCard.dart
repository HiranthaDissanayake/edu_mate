import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Reportdetailscard extends StatelessWidget {
  final dynamic title;
  final dynamic data;

  const Reportdetailscard({
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
          padding: const EdgeInsets.all(8.0),
          child: Text(title ,style: GoogleFonts.poppins(color: title == "Marks : " ? Color(0xFFF34EF9) : Color(0xFF308FAF),fontSize: 17, fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(data,style: GoogleFonts.poppins(color: data == "Mathematics" ? Color(0xFF308FAF) : Colors.white,fontSize: 17, fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }
}