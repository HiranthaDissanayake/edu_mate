import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseMethods {
  //Set Student Details
  Future addStudentDetails(
      Map<String, dynamic> studentInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Students")
        .doc(id)
        .set(studentInfoMap);
  }

  //Set Admin Details
  Future addAdminDetails(Map<String, dynamic> adminInfoMap, String id) async {
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

  //get schedule
  Future<Stream<QuerySnapshot>> getSchedules() async {
    return await FirebaseFirestore.instance.collection('Schedules').snapshots();
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
  
  Future<DocumentSnapshot<Object?>> fetchPrivacyPolicy() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("privacy_policy")
        .doc("latest_privacy_policy")
        .get();

    return snapshot;
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

// get the user role based on email
  Future<String?> getUserRole(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String role = querySnapshot.docs.first.get("role");

        if (role == "student") {
          return "student";
        } else if (role == "teacher") {
          return "teacher";
        } else if (role == "admin") {
          return "admin";
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user role: $e");
      return null;
    }
  }

//save the user's email and role in SharedPreferences
  Future<void> saveLoginData(String email, String password, String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString("password", password);
    await prefs.setString('role', role);
  }

  /// *Fetch Grades for a Given Teacher*
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

  //Add student marks
  Future<void> addStudentMarks(
      String studentId, String testNo, String marks) async {
    try {
      await FirebaseFirestore.instance
          .collection('Students') // Main collection
          .doc(studentId) // Locate the student by ID
          .collection('Marks') // Subcollection for storing marks
          .doc(testNo) // Each test has its own document
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
  Future<void> editStudentMarks(
      String studentId, String testNo, String newMarks) async {
    try {
      await FirebaseFirestore.instance
          .collection('Students') // Locate the main collection
          .doc(studentId) // Find the specific student
          .collection('Marks') // Navigate to Marks subcollection
          .doc(testNo) // Find the test document
          .update({
        'marks': newMarks, // Update the marks field
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("Marks updated successfully!");
    } catch (e) {
      print("Error updating marks: $e");
    }
  }

  Future<Stream<DocumentSnapshot>> getDocument(
      String collection, String id) async {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .snapshots();
  }
}
