import 'package:edu_mate/Teacher/TeacherDashboard.dart';
import 'package:flutter/material.dart';

class Sendalerts extends StatefulWidget {
  const Sendalerts({super.key});

  @override
  State<Sendalerts> createState() => _SendalertsState();
}

class _SendalertsState extends State<Sendalerts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
      decoration: 
      BoxDecoration(
        gradient: LinearGradient
        (
          colors: [Color(0xFF2C2C88), Color(0xFF0B0B22)],
          stops: [0.15,0.4],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft, 
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(125), bottomLeft: Radius.circular(65)),
              gradient: LinearGradient(
                colors:[Color(0xFF010127), Color(0xFF0B0C61)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Teacherdashboard()),
                     );
                  }, 
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  ),
                  Text(
                    'Send Alerts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "      "
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF080B2E),
                // color: const Color.fromARGB(255, 99, 97, 97),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text(
                      'Message',
                      style: TextStyle(color: Colors.white,
                      fontSize: 17,
                      ),  
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline, // Enables multi-line input
                      maxLines: 8, // Allows unlimited lines (adjust as needed)
                      minLines: 8, // Sets a minimum height (adjust as needed)                          
                      decoration: InputDecoration(
                        fillColor: Color(0xFF26284A),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        hintText: "Type message here",
                        hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 97, 97, 97),
                          ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),     
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 40,
                        width: 140,
                        child: ElevatedButton(onPressed: (){
                  
                        }, 
                        child:
                         Text(
                          'Send',
                          style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF3A2AE0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
     ),
    );
  }
}