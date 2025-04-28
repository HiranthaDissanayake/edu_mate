import 'package:edu_mate/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StudetDrawer extends StatefulWidget {
  const StudetDrawer({super.key});

  @override
  State<StudetDrawer> createState() => _StudetDrawerState();
}

class _StudetDrawerState extends State<StudetDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 115, 161, 187),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 36, 42, 137),
            ),
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
          ListTile(
            leading: Icon(
              Icons.dashboard_outlined,
              color: Colors.black,
            ),
            title: Text(
              'Dashboard',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.privacy_tip_outlined,
              color: Colors.black,
            ),
            title: Text(
              'Privacy & Policy',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/events');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
            ),
            title: Text(
              'Notifications',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          Divider(
            color: const Color.fromARGB(255, 121, 118, 118),
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 9, 3, 42),
              ),
              onPressed: () async {
                final secureStorage = const FlutterSecureStorage();
                await secureStorage.delete(key: "email");
                await secureStorage.delete(key: "password");
                await secureStorage.delete(key: "role");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Splashscreen()),
                );
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          )
        ],
      ),
    );
  }
}
