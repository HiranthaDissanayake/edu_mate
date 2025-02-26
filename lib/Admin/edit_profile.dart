import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String id;
  final String collection;
  final String name;
  final String email;
  final String birthday;
  final String grade;
  final List<String> grades;
  final String gender;
  final String subject;
  final List<String> subjects;
  final String qualification;
  final String contactNo;
  final String parentContactNo;

  const EditProfileScreen({
    super.key,
    required this.id,
    required this.collection,
    required this.name,
    required this.email,
    required this.birthday,
    required this.grade,
    required this.grades,
    required this.gender,
    required this.subject,
    required this.subjects,
    required this.qualification,
    required this.contactNo,
    required this.parentContactNo,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController birthdayController;
  late TextEditingController gradeController;
  late TextEditingController subjectController;
  late TextEditingController qualificationController;
  late TextEditingController contactNoController;
  late TextEditingController parentContactNoController;
  late String gender;
  late List<String> grades;
  late List<String> subjects;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    birthdayController = TextEditingController(text: widget.birthday);
    gradeController = TextEditingController(text: widget.grade);
    subjectController = TextEditingController(text: widget.subject);
    qualificationController = TextEditingController(text: widget.qualification);
    contactNoController = TextEditingController(text: widget.contactNo);
    parentContactNoController =
        TextEditingController(text: widget.parentContactNo);
    gender = widget.gender;
    grades = List.from(widget.grades);
    subjects = List.from(widget.subjects);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    birthdayController.dispose();
    gradeController.dispose();
    subjectController.dispose();
    qualificationController.dispose();
    contactNoController.dispose();
    parentContactNoController.dispose();
    super.dispose();
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection(widget.collection)
            .doc(widget.id)
            .update({
          "Name": nameController.text,
          "Email": emailController.text,
          "DateOfBirth": birthdayController.text,
          "Grade":
              widget.collection == 'Students' ? gradeController.text : grades,
          "Subject": widget.collection == 'Students'
              ? subjects
              : subjectController.text,
          "ContactNo": contactNoController.text,
          "ParentNo": widget.collection == 'Students'
              ? parentContactNoController.text
              : null,
          "Gender": widget.collection == 'Teachers' ? gender : null,
          "Qualification": widget.collection == 'Teachers'
              ? qualificationController.text
              : null,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully!")),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating profile: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF13134C),
                  Color(0xFF13134C),
                  Color(0XFF2D2DB2)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
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
                        Spacer(),
                        Text(
                          "Edit Profile",
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
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        TextFormField(
                          controller: nameController,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              labelText: "Name",
                              labelStyle: TextStyle(color: Colors.white)),
                          validator: (value) =>
                              value!.isEmpty ? "Enter name" : null,
                        ),
                        TextFormField(
                          controller: emailController,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.white)),
                          validator: (value) =>
                              value!.isEmpty ? "Enter email" : null,
                        ),
                        TextFormField(
                          controller: birthdayController,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              labelText: "Birthday",
                              labelStyle: TextStyle(color: Colors.white)),
                          validator: (value) =>
                              value!.isEmpty ? "Enter birthday" : null,
                        ),
                        if (widget.collection == 'Students') ...[
                          TextFormField(
                            controller: gradeController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                labelText: "Grade",
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                          TextFormField(
                            controller: contactNoController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                labelText: "Contact No",
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                          TextFormField(
                            controller: parentContactNoController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                labelText: "Parent Contact No",
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                        ] else if (widget.collection == 'Teachers') ...[
                          DropdownButtonFormField<String>(
                            dropdownColor: Colors.blue[900],
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            value: gender,
                            items: ['Male', 'Female']
                                .map((g) =>
                                    DropdownMenuItem(value: g, child: Text(g)))
                                .toList(),
                            onChanged: (value) =>
                                setState(() => gender = value!),
                            decoration: const InputDecoration(
                                labelText: "Gender",
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                          TextFormField(
                            controller: subjectController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                labelText: "Subject",
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                          TextFormField(
                            controller: qualificationController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                labelText: "Qualification",
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                          TextFormField(
                            controller: contactNoController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                labelText: "Contact No",
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                        ],
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _updateProfile,
                          child: const Text("Save Changes"),
                        ),
                      ],
                    ),
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
