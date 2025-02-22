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
            leading: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset("assets/images/privacy_policy.png"),
            ),
            title:
                Text("Privacy & Policy", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
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
