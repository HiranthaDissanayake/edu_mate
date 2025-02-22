import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Subjectdetailscard extends StatelessWidget {
  final String title;
  final List data;

  const Subjectdetailscard({
    super.key,
    required this.title,
    required this.data,
    });

  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(title ,style: GoogleFonts.poppins(color: title == "Date" ? Color(0xFFB2383A): title == "Time" ? Color(0xFFB2383A) : title == "Teacher"? Color(0xFF5342FF) : Colors.white,fontSize: 19, fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(data.length, (index) {
                  return Text(
                    data[index].toString(),
                    style: GoogleFonts.poppins(
                          color: data[index] == "Science" ? Color(0xFF308FAF) : data[index] == "History" ? Color.fromARGB(255, 231, 213, 56) : data[index] == "Commerce" ? Color.fromARGB(255, 60, 235, 138) : data[index] == "Maths" ? Color.fromARGB(255, 238, 113, 64) : data[index] == "English" ? Color.fromARGB(255, 196, 73, 230) : const Color.fromARGB(255, 247, 46, 46),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}