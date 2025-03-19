import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/service/database.dart';
import 'package:flutter/material.dart';
import 'package:edu_mate/Admin/edit_profile.dart';

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
  List<String> grades = [];
  String gender = '';
  String subject = '';
  List<String> subjects = [];
  String qualification = '';
  String contactNo = '';
  String parentContactNo = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
    print(widget.id);
  }

  // Function to fetch a single student from Firestore
  void _fetchData() async {
    try {
      Stream<DocumentSnapshot> dataStream =
          await DatabaseMethods().getDocument(widget.collection, widget.id);

      dataStream.listen((document) {
        if (document.exists) {
          setState(() {
            if (widget.collection == 'Students') {
              name = document['Name'];
              email = document['Email'];
              birthday = document['DateOfBirth'];
              grade = document['Grade'];
              subjects = List<String>.from(document['Subject']);
              contactNo = document['ContactNo'];
              parentContactNo = document['ParentNo'];
            } else if (widget.collection == 'Teachers') {
              name = document['Name'];
              email = document['Email'];
              birthday = document['DateOfBirth'];
              gender = document['Gender'];
              grades = List<String>.from(document['Grade']);
              qualification = document['Quelification'];
              subject = document['Subject'];
              contactNo = document['ContactNo'];
            }
          });
        } else {
          print("Document not found.");
        }
      });
    } catch (error) {
      print("Error fetching document: $error");
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
            // App Bar (Fixed at the top)
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF010127), const Color(0xFF0B0C61)],
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

            // Scrollable Content
            Positioned(
              top: 120, // Position below the app bar
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),

                    // Profile Picture
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image:
                                AssetImage("assets/images/student_logo.png")),
                      ),
                    ),
                    SizedBox(height: 20),

                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 40),

                    _buildProfileDetailTable("Email", email),
                    if (widget.collection == 'Students') ...[
                      _buildProfileDetailTable("Birthday", birthday),
                      _buildProfileDetailTable("Grade", grade),
                      _buildProfileDetailTable("Subjects", subjects.join(", ")),
                      _buildProfileDetailTable("Contact No", contactNo),
                      _buildProfileDetailTable(
                          "Parent Contact No", parentContactNo),
                    ] else if (widget.collection == 'Teachers') ...[
                      _buildProfileDetailTable("Birthday", birthday),
                      _buildProfileDetailTable("Grade", grades.join(",\n ")),
                      _buildProfileDetailTable("Gender", gender),
                      _buildProfileDetailTable("Subject", subject),
                      _buildProfileDetailTable("Contact No", contactNo),
                      _buildProfileDetailTable("Qualification", qualification),
                    ],

                    SizedBox(height: 50),

                    // Edit Profile Button
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                id: widget.id,
                                collection: widget.collection,
                                name: name,
                                email: email,
                                birthday: birthday,
                                grade: grade,
                                grades: grades,
                                gender: gender,
                                subject: subject,
                                subjects: subjects,
                                qualification: qualification,
                                contactNo: contactNo,
                                parentContactNo: parentContactNo,
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xFF3A2AE0)),
                        ),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display profile details in a row
  Widget _buildProfileDetailTable(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Table(
        defaultColumnWidth: const FlexColumnWidth(1.0),
        border: TableBorder.all(color: Colors.transparent),
        children: [
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
