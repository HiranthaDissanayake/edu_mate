import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/service/auth_service.dart';
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
   //Set Admin Details
  Future addAdminDetails(
      Map<String, dynamic> adminInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Admin")
        .doc(id)
        .set(adminInfoMap);
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

  //send alerts
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




  //Add the attendance column
  Future<void> addAttendanceFieldToAllStudents() async {
    CollectionReference students =
        FirebaseFirestore.instance.collection('Students');

    QuerySnapshot snapshot = await students.get();

    for (var doc in snapshot.docs) {
      await students.doc(doc.id).update({
        'attendance': {} // Adding an empty map
      }).then((_) {
        print("Updated student ${doc.id}");
      }).catchError((error) {
        print("Failed to update student ${doc.id}: $error");
      });
    }
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
  // Fetch privacy policy

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

  //set user role for student
  Future<void> setStudentRole(String id, String email) async {
    try {
      // 🔹 Create Student Account
      User? user =
          await AuthService().createEmailAndPasswordForStudent(email, id);

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'role': 'student',
          'createdAt': FieldValue.serverTimestamp(),
        });

        print(" Student role added successfully!");
      } else {
        print(" Failed to add student role.");
      }
    } catch (e) {
      print(" Error add student role: $e");
    }
  }

  //set user role for teacher
  Future<void> setTeacherRole(String id, String email) async {
    try {
      // 🔹 Create Student Account
      User? user =
          await AuthService().createEmailAndPasswordForStudent(email, id);

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'role': 'teacher',
          'createdAt': FieldValue.serverTimestamp(),
        });

        print(" teacher role added successfully!");
      } else {
        print(" Failed to add teacher role.");
      }
    } catch (e) {
      print(" Error add teacher role: $e");
    }
  }


  
  //set user role for student
  Future<void> setAdminRole(String id, String email) async {
    try {
      // 🔹 Create Student Account
      User? user =
          await AuthService().createEmailAndPasswordForStudent(email, id);

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'role': 'admin',
          'createdAt': FieldValue.serverTimestamp(),
        });

        print(" Admin role added successfully!");
      } else {
        print(" Failed to add admin role.");
      }
    } catch (e) {
      print(" Error add admin role: $e");
    }
  }

     /// **Fetch Grades for a Given Teacher**
  Future<List<String>> fetchGrades(String teacherID) async {
  try {
    DocumentSnapshot teacherDoc = await FirebaseFirestore.instance
        .collection('Teachers')
        .doc(teacherID)
        .get();

    if (!teacherDoc.exists) {
      print("No document found for teacher: $teacherID");
      return [];
    }

    if (!teacherDoc.data().toString().contains('Grade')) {
      print("Error: 'Grade' field is missing in Firestore document");
      return [];
    }

    var gradesData = teacherDoc.get('Grade');
    if (gradesData is List) {
      return List<String>.from(gradesData);
    } else {
      print("Error: 'Grade' is not a valid list");
      return [];
    }
  } catch (e) {
    print("Error fetching grades: $e");
    return [];
  }
}


}
