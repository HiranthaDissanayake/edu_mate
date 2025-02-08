import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Registerstudent extends StatefulWidget {
  const Registerstudent({super.key});

  @override
  State<Registerstudent> createState() => _RegisterstudentState();
}

class _RegisterstudentState extends State<Registerstudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 2, 3, 87),
              const Color.fromARGB(255, 18, 52, 126)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 2, 1, 95),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Image(image: AssetImage("asssets/images/AppLogo.png"),
                height: 100,
                width: 100,
                ),
                Text("REGISTER STUDENT",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                ),),
                Form(child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 13, 0, 253)
                              )
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 36, 36, 63),
                            labelText: "Full Name",
                            labelStyle: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 13, 0, 253)
                              )
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 36, 36, 63),
                            labelText: "Date Of Birth",
                            labelStyle: TextStyle(
                              color: Colors.white
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                showDatePicker(context: context, firstDate: DateTime(2004), lastDate: DateTime.now());
                                
                              },
                            color: Colors.white,
                            icon: Icon(Icons.calendar_month),
                            ),
                          ),
                          
                        ),
                      ),
                    ],
                  ),
                )),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
