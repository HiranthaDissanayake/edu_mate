import 'package:edu_mate/Admin/admin_home_page.dart';
import 'package:edu_mate/Admin/privacy_and_policy.dart';
import 'package:edu_mate/Admin/register_admin.dart';
import 'package:edu_mate/Admin/terms_and_conditions.dart';
import 'package:edu_mate/Screens/splashScreen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
      child: Column(
        children: [
          // Drawer Header
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
            ),
          ),
          // List of Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Adminhomepage()),
                    );
                  },
                  leading: SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset("assets/images/dashboard.png"),
                  ),
                  title:
                      Text("Dashboard", style: TextStyle(color: Colors.white)),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registeradmin()),
                    );
                  },
                  leading: SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset("assets/images/registerAdmin.png"),
                  ),
                  title: Text("Register Admin",
                      style: TextStyle(color: Colors.white)),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicyScreen()),
                    );
                  },
                  leading: SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset("assets/images/privacy_policy.png"),
                  ),
                  title: Text("Privacy & Policy",
                      style: TextStyle(color: Colors.white)),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Termsandconditions()),
                    );
                  },
                  leading: SizedBox(
                    height: 25,
                    width: 25,
                    child:
                        Image.asset("assets/images/terms_and_conditions.png"),
                  ),
                  title: Text("Terms & Conditions",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: GestureDetector(
              onTap: () async {
                final _secureStorage = const FlutterSecureStorage();
                await _secureStorage.delete(key: "email");
                await _secureStorage.delete(key: "password");
                await _secureStorage.delete(key: "role");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Splashscreen1()),
                );
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
          ),
        ],
      ),
    );
  }
}
