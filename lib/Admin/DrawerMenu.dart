import 'package:edu_mate/Admin/AdminHomePage.dart';
import 'package:edu_mate/Screens/LoginScreen.dart';
import 'package:edu_mate/Admin/PrivacyAndPolicy.dart';
import 'package:edu_mate/Admin/RegisterAdmin.dart';
import 'package:edu_mate/Admin/TermsAndConditions.dart';
import 'package:flutter/material.dart';

class Drawermenu extends StatefulWidget {
  const Drawermenu({super.key});

  @override
  State<Drawermenu> createState() => _DrawermenuState();
}

class _DrawermenuState extends State<Drawermenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF080A30),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              child: Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/AppLogo.png",
                  width: 80,
                  height: 80,
                ),
                Text(
                  "EduMate",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          )),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Adminhomepage()));
            },
            leading: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset("assets/images/dashboard.png"),
            ),
            title: Text("Dashboard", style: TextStyle(color: Colors.white))

        ),
        
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Registeradmin()));
            },
            leading: SizedBox(
              //terms_and_conditions.png
              height: 25,
              width: 25,
              child: Image.asset("assets/images/registerAdmin.png"),
            ),
            title: Text("Register Admin",
                style: TextStyle(color: Colors.white)),
          ),


          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Privacyandpolicy()));
            },
            leading: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset("assets/images/privacy_policy.png"),
            ),
            title:
                Text("Privacy & Policy", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Termsandconditions()));
            },
            leading: SizedBox(
              //terms_and_conditions.png
              height: 25,
              width: 25,
              child: Image.asset("assets/images/terms_and_conditions.png"),
            ),
            title: Text("Terms & Conditions",
                style: TextStyle(color: Colors.white)),
          ),
          SizedBox(
            height: 360,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginscreen(role: "admin",)));
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF3A2AE0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
