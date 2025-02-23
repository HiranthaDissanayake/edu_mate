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

  //Add student marks
  Future<void> addStudentMarks(String studentId, String testNo, String marks) async {
    try {
      await FirebaseFirestore.instance
          .collection('Students')  // Main collection
          .doc(studentId)          // Locate the student by ID
          .collection('Marks')     // Subcollection for storing marks
          .doc(testNo)             // Each test has its own document
          .set({
        'testNo': testNo,
        'marks': marks,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("Marks added successfully!");
    } catch (e) {
      print("Error adding marks: $e");
    }
  }

  //Edit student marks
   Future<void> editStudentMarks(String studentId, String testNo, String newMarks) async {
    try {
      await FirebaseFirestore.instance
          .collection('Students')   // Locate the main collection
          .doc(studentId)           // Find the specific student
          .collection('Marks')      // Navigate to Marks subcollection
          .doc(testNo)              // Find the test document
          .update({
        'marks': newMarks,          // Update the marks field
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("Marks updated successfully!");
    } catch (e) {
      print("Error updating marks: $e");
    }
  }

   Future<void> sendAlert(String message) async {
    try {
      // Get the number of current alerts in the 'Alerts' collection
      QuerySnapshot alertsSnapshot = await _firestore.collection('Alerts').get();
      int alertCount = alertsSnapshot.size;

      // Generate the next alert ID
      String alertId = 'Alert_ID_${(alertCount + 1).toString().padLeft(3, '0')}';

      // Save the alert to Firestore
      await _firestore.collection('Alerts').doc(alertId).set({
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("Alert sent successfully!");
    } catch (e) {
      print("Error sending alert: $e");
    }
  }


}

