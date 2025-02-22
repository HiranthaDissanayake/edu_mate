import 'package:edu_mate/Teacher/LoginScreen.dart';
import 'package:edu_mate/Teacher/TeacherDashboard.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF080A30),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 250,
              child: DrawerHeader(
                // padding: EdgeInsets.only(top: 10),
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [Color(0xFF2C2C88), Color(0xFF0B0B22)],
                //     begin: Alignment.bottomCenter,
                //     end: Alignment.topCenter,
                //   ),
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/teacher_profile.png'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'TID      :199660630',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'G-mail :jayawardhane@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
        
            Column(

              children: [
                ListTile(
                  leading: Icon(Icons.dashboard_rounded, color: const Color.fromARGB(255, 255, 255, 255)),
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                    ),
                  onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Teacherdashboard()),
                        );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.privacy_tip, color: const Color.fromARGB(255, 255, 255, 255)),
                  title: Text(
                    'Privacy & Policy',
                    style: TextStyle(color: Colors.white)
                    ),
                  onTap: () {
                
                  },
                ),
                ListTile(
                  leading: Icon(Icons.content_copy_outlined, color: const Color.fromARGB(255, 255, 255, 255)),
                  title: Text(
                    'Terms & Conditions',
                    style: TextStyle(color: Colors.white)
                    ),
                  onTap: () {
                        
                  },
                ),
                
                ListTile(
                  leading: Icon(Icons.settings, color: const Color.fromARGB(255, 255, 255, 255)),
                  title: Text(
                    'Settings',
                    style: TextStyle(color: Colors.white)
                    ),
                  onTap: () {
                        
                  },
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 150,left: 40, right: 40),
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }, 
              child:
                 Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3A2AE0),
               ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}