import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/service/database.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String id;
  final String collection;

  const ProfileScreen({super.key, required this.id, required this.collection});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String email = '';
  String birthday = '';
  String grade = '';
  List<String> subjects = [];
  String contactNo = '';
  String parentContactNo = '';

  @override
  void initState() {
    super.initState();
    _fetchStudent();
    print(widget.id);
  }

  // Function to fetch a single student from Firestore
  void _fetchStudent() async {
    try {
      Stream<DocumentSnapshot> studentStream =
          await DatabaseMethods().getStudent(widget.id);

      studentStream.listen((document) {
        if (document.exists) {
          setState(() {
            name = document['Name'];
            email = document['Email'];
            birthday = document['DateOfBirth'];
            grade = document['Grade'];
            subjects =
                List<String>.from(document['Subject']); // Ensure list type
            contactNo = document['ContactNo'];
            parentContactNo = document['ParentNo'];
          });
        } else {
          print("Student not found.");
        }
      });
    } catch (error) {
      print("Error fetching student: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF13134C),
              const Color(0xFF13134C),
              const Color(0XFF2D2DB2)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // Custom Appbar
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF010127),
                        const Color(0xFF0B0C61)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      topRight: Radius.circular(150),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          iconSize: 25,
                        ),
                        SizedBox(width: 120),
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Profile Picture
                SizedBox(
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(
                        image: AssetImage("assets/images/student_logo.png")),
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),

                _buildProfileDetail("Email", email),
                _buildProfileDetail("Birthday", birthday),
                _buildProfileDetail("Grade", grade),
                _buildProfileDetail("Subjects", subjects.join(", ")),
                _buildProfileDetail("Contact No", contactNo),
                _buildProfileDetail("Parent Contact No", parentContactNo),

                SizedBox(height: 50),

                // Edit Profile Button
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF3A2AE0)),
                    ),
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget to display profile details in a row
  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }
}
