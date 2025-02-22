import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  //Set Student Details
  Future addStudentDetails(
      Map<String, dynamic> studentInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Students")
        .doc(id)
        .set(studentInfoMap);
  }

  //Set Teachers Details
  Future addTeacherDetails(
      Map<String, dynamic> teacherInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Teachers")
        .doc(id)
        .set(teacherInfoMap);
  }

  //set schedule
  Future setClassSchedule(Map<String, dynamic> scheduleMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Schedules")
        .doc(id)
        .set(scheduleMap);
  }

  // Fetch all Student details
  Future<Stream<QuerySnapshot>> getStudents() async {
    return await FirebaseFirestore.instance.collection("Students").snapshots();
  }

  // Fetch all Teachers details
  Future<Stream<QuerySnapshot>> getTeachers() async {
    return await FirebaseFirestore.instance.collection("Teachers").snapshots();
  }

  Future<Stream<DocumentSnapshot>> getStudent(String id) async {
    return await FirebaseFirestore.instance
        .collection("Students")
        .doc(id)
        .snapshots();
  }

  // Delete a student from the collection
  Future<void> deleteStudent(String id) async {
    return await FirebaseFirestore.instance
        .collection("Students")
        .doc(id)
        .delete();
  }

  // Fetch terms and conditions
  Future<List<String>> fetchTermsAndConditions() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("terms_conditions")
        .doc("latest_terms")
        .get();

     String termsText = snapshot["content"];

    // Splitting the terms at each numbered item (e.g., "01.", "02.", etc.)
    List<String> termsList = termsText.split(RegExp(r'(?=\d{2}\.)'));

    return termsList.map((e) => e.trim()).toList(); // Trim whitespace
  }


  
  // Fetch terms and conditions
  Future<List<String>> fetchPrivacyPolicy() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("privacy_policy")
        .doc("latest_privacy_policy")
        .get();

     String termsText = snapshot["content"];

    // Splitting the terms at each numbered item (e.g., "01.", "02.", etc.)
    List<String> privacyList = termsText.split(RegExp(r'(?=\d{2}\.)'));

    return privacyList.map((e) => e.trim()).toList(); // Trim whitespace
  }
  
}
