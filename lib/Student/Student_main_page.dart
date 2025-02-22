import 'package:edu_mate/Student/components/Categories/AttendenceContainer.dart';
import 'package:edu_mate/Student/components/Categories/ClassesContainer.dart';
import 'package:edu_mate/Student/components/Categories/ReportContainer.dart';
import 'package:edu_mate/Student/components/Studet_Drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentMainPage extends StatefulWidget {
  const StudentMainPage({super.key});

  @override
  State<StudentMainPage> createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {

  String stId = "u7bK138034";
  String grade = "Grade 9";

  int _selectedMethod = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 65, 117, 147),
        drawer: StudetDrawer(),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/5.5),
                    height: MediaQuery.of(context).size.height/1.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF13134C),
                          Color(0xFF2D2DB2)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  
                  Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: (){
                          setState(() {
                            Scaffold.of(context).openDrawer();
                          });
                          
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 50,left: 20),
                          child: Icon(Icons.menu, color: Colors.white,size: 30,),
                        )
                      );
                    },
                  ),
              
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                          child: Container(
                              margin: EdgeInsets.only(top: 70),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white
                              ),
                              child: Center(child: Image.asset("assets/images/student_logo.png",fit: BoxFit.contain,)),
                          ),
                      ),
                    ],
                  ),
              
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3.7),
                      height: MediaQuery.of(context).size.height/9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color(0xFF080B2E),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Text("Student ID : ",style: GoogleFonts.poppins(color: Colors.white,fontSize: 17, fontWeight: FontWeight.bold),),
                                        Text(stId,style: GoogleFonts.poppins(color: Colors.white,fontSize: 17, fontWeight: FontWeight.bold),)
                                    ],
                                ),
                              ),
              
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Text("Student Name : ",style: GoogleFonts.poppins(color: Colors.white,fontSize: 17, fontWeight: FontWeight.bold),),
                                        Text("Dilum Gamlath",style: GoogleFonts.poppins(color: Colors.white,fontSize: 17, fontWeight: FontWeight.bold),)
                                    ],
                                ),
                              ),
                          ],
                      ),
                    ),
                  ),
              
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                            },
                            child: Container(
                              width: 110,
                              height: 50,
                              decoration: BoxDecoration(
                                color: _selectedMethod == 0 ? Color(0xFF080B2E) : Color(0xFFD4DCFF),
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Center(child: Text("classes",style: GoogleFonts.poppins(color: _selectedMethod == 0 ? Colors.white : Color(0xFF13134C),fontSize: 15, fontWeight: FontWeight.bold),)),
                            ),
                          ),
                        ),
                         Padding(
                           padding: const EdgeInsets.all(10),
                           child: GestureDetector(
                             onTap: (){
                              _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);
                             },
                             child: Container(
                              width: 110,
                              height: 50,
                              decoration: BoxDecoration(
                                color: _selectedMethod == 1 ? Color(0xFF080B2E) : Color(0xFFD4DCFF),
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Center(child: Text("report",style: GoogleFonts.poppins(color: _selectedMethod == 1 ? Colors.white : Color(0xFF13134C),fontSize: 15, fontWeight: FontWeight.bold),)),
                            ),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(10),
                           child: GestureDetector(
                             onTap: (){
                              _pageController.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.ease);
                               
                             },
                             child: Container(
                              width: 110,
                              height: 50,
                              decoration: BoxDecoration(
                                color: _selectedMethod == 2 ? Color(0xFF080B2E) : Color(0xFFD4DCFF),
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Center(child: Text("attendence",style: GoogleFonts.poppins(color: _selectedMethod == 2 ? Colors.white : Color(0xFF13134C),fontSize: 15, fontWeight: FontWeight.bold),)),
                            ),
                           ),
                         ),
                      ],
                    ),
                  ),
              
                  
              
                ],
                
              ),
            ),

            Expanded(
              flex: 1,
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    height: MediaQuery.of(context).size.height/3,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 65, 117, 147),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _selectedMethod == 0 ? Classescontainer(stId: stId, grade: grade) : _selectedMethod == 1 ?  Reportcontainer() : Attendencecontainer(),
              
                        ],
                      ),
                    )
                  );
                },
                itemCount: 3,
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _selectedMethod = value;
                  });
                },
              ),
            )
          ],
        ),
    );
  }
}