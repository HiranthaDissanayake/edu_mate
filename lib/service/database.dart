import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
  
// Future<void> addAttendanceFieldToAllStudents() async {
//   CollectionReference students = FirebaseFirestore.instance.collection('Students');

//   QuerySnapshot snapshot = await students.get();

//   for (var doc in snapshot.docs) {
//     // Safely check if 'attendance' field exists by first checking if data is not null
//     var studentData = doc.data() as Map<String, dynamic>?;

//     if (studentData != null && !studentData.containsKey('attendance')) {
//       await students.doc(doc.id).update({
//         'attendance': {}, // Adding an empty map if not exists
//       }).then((_) {
//         print("Added attendance field for student ${doc.id}");
//       }).catchError((error) {
//         print("Failed to update student ${doc.id}: $error");
//       });
//     }
//   }
// }

 // **Authenticate User**
  Future<User?> loginTeacher(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  // **Fetch Teacher Details**
  Future<Map<String, dynamic>?> getTeacherDetails(String uid) async {
    try {
      DocumentSnapshot teacherDoc =
          await _firestore.collection('Teachers').doc(uid).get();
      return teacherDoc.exists ? teacherDoc.data() as Map<String, dynamic> : null;
    } catch (e) {
      print("Error Fetching Teacher Details: $e");
      return null;
    }
  }

}

