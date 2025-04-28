import 'package:edu_mate/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NavBar extends StatelessWidget {
  final String teacherID;
  final String teacherEmail;

  const NavBar({
    super.key,
    required this.teacherID,
    required this.teacherEmail,
  });

  Future<Map<String, dynamic>> fetchTeacherData(String teacherID) async {
    var docSnapshot = await FirebaseFirestore.instance
        .collection('Teachers') 
        .doc(teacherID) 
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.data()!; 
    } else {
      throw Exception('Teacher not found');
    }
  }

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
              child: FutureBuilder<Map<String, dynamic>>(
                future: fetchTeacherData(teacherID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No teacher data found'));
                  } else {
                    var teacherData = snapshot.data!;
                    String teacherImageURL = teacherData['profileImage'] ?? 'https://drive.google.com/uc?export=view&id=1cogzIZVFFQMgVfr8emlld-PclxPUzqpv';

                    return DrawerHeader(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ClipOval(
                              child: Image.network(
                                teacherImageURL,
                                height: 90,
                                width: 90,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                    'https://drive.google.com/uc?export=view&id=1cogzIZVFFQMgVfr8emlld-PclxPUzqpv',
                                    height: 40,
                                    width: 40,
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'TID      : $teacherID',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'E-mail : $teacherEmail',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            // Other drawer items
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.dashboard_rounded, color: Colors.white),
                  title: Text('Home', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.privacy_tip, color: Colors.white),
                  title: Text('Privacy & Policy', style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.content_copy_outlined, color: Colors.white),
                  title: Text('Terms & Conditions', style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.white),
                  title: Text('Settings', style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150, left: 40, right: 40),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Loginscreen(role: 'Teacher')),
                  );
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3A2AE0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
