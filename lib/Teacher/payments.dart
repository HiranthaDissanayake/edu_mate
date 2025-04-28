import 'package:edu_mate/Teacher/TeacherDashboard.dart';
import 'package:flutter/material.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
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
                    Navigator.pop(context);
                  }, 
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  ),
                  Text(
                    'Payments',
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
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 35,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Color(0xFF181C5C),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(
                        'Transaction Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 550,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF080B2E).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20),
                  child: Container(
                    height: 80,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Color(0xFF26284A).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Students Paid : ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Due Payments: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ), 
                  ),
                ),
              ],
            )
          ],
        ),
        ],
      ),
     ),
    );
  }
}
