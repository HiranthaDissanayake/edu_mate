import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/service/auth_service.dart';
import 'package:edu_mate/service/sqlite_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:edu_mate/service/app_logger.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SQLiteHelper _sqliteHelper = SQLiteHelper();

  //Set Student Details
  Future<void> addStudentDetails(
      Map<String, dynamic> studentInfoMap, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("Students")
          .doc(id)
          .set(studentInfoMap);

      bool paymentRecordsGenerated = await generatePaymentRecordsForStudent(id);

      if (paymentRecordsGenerated) {
        AppLogger()
            .d("Payment records generated successfully for student: $id");
      } else {
        AppLogger().w("Failed to generate payment records for student: $id");
      }

      return;
    } catch (e) {
      AppLogger().e("Error adding student details: $e");
      rethrow;
    }
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

  //Fetch all Teachers details
  Future<Stream<QuerySnapshot>> getTeachers() async {
    return await FirebaseFirestore.instance.collection("Teachers").snapshots();
  }

  Future<Stream<DocumentSnapshot>> getStudent(String id) async {
    return FirebaseFirestore.instance
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
      await students.doc(doc.id).update({'attendance': {}}).then((_) {
        AppLogger().d("Updated student ${doc.id}");
      }).catchError((error) {
        AppLogger().e("Failed to update student ${doc.id}: $error");
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

    List<String> termsList = termsText.split(RegExp(r'(?=\d{2}\.)'));

    return termsList.map((e) => e.trim()).toList();
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
      User? user =
          await AuthService().createEmailAndPasswordForStudent(email, id);

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'role': 'student',
          'createdAt': FieldValue.serverTimestamp(),
        });

        AppLogger().i("Student role added successfully!");
      } else {
        AppLogger().w("Failed to add student role.");
      }
    } catch (e) {
      AppLogger().e("Error adding student role: $e");
    }
  }

  //set user role for teacher
  Future<void> setTeacherRole(String id, String email) async {
    try {
      User? user =
          await AuthService().createEmailAndPasswordForStudent(email, id);

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'role': 'teacher',
          'createdAt': FieldValue.serverTimestamp(),
        });

        AppLogger().i("Teacher role added successfully!");
      } else {
        AppLogger().w("Failed to add teacher role.");
      }
    } catch (e) {
      AppLogger().e("Error adding teacher role: $e");
    }
  }

  //set user role for admin
  Future<void> setAdminRole(String id, String email) async {
    try {
      User? user =
          await AuthService().createEmailAndPasswordForStudent(email, id);

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'role': 'admin',
          'createdAt': FieldValue.serverTimestamp(),
        });

        AppLogger().i("Admin role added successfully!");
      } else {
        AppLogger().w("Failed to add admin role.");
      }
    } catch (e) {
      AppLogger().e("Error adding admin role: $e");
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
      AppLogger().e("Error fetching user role: $e");
      return null;
    }
  }

  /// *Fetch Grades for a Given Teacher*
  Future<List<String>> fetchGrades(String teacherID) async {
    try {
      DocumentSnapshot teacherDoc = await FirebaseFirestore.instance
          .collection('Teachers')
          .doc(teacherID)
          .get();

      if (!teacherDoc.exists) {
        AppLogger().w("No document found for teacher: $teacherID");
        return [];
      }

      if (!teacherDoc.data().toString().contains('Grade')) {
        AppLogger().w("Error: 'Grade' field is missing in Firestore document");
        return [];
      }

      var gradesData = teacherDoc.get('Grade');
      if (gradesData is List) {
        return List<String>.from(gradesData);
      } else {
        AppLogger().w("Error: 'Grade' is not a valid list");
        return [];
      }
    } catch (e) {
      AppLogger().e("Error fetching grades: $e");
      return [];
    }
  }

  //Add student marks
  Future<void> addStudentMarks(
      String studentId, String testNo, String marks) async {
    try {
      await FirebaseFirestore.instance
          .collection('Students')
          .doc(studentId)
          .collection('Marks')
          .doc(testNo)
          .set({
        'testNo': testNo,
        'marks': marks,
        'timestamp': FieldValue.serverTimestamp(),
      });

      AppLogger().i("Marks added successfully!");
    } catch (e) {
      AppLogger().e("Error adding marks: $e");
    }
  }

  //Edit student marks
  Future<void> editStudentMarks(
      String studentId, String testNo, String newMarks) async {
    try {
      await FirebaseFirestore.instance
          .collection('Students')
          .doc(studentId)
          .collection('Marks')
          .doc(testNo)
          .update({
        'marks': newMarks,
        'timestamp': FieldValue.serverTimestamp(),
      });

      AppLogger().i("Marks updated successfully!");
    } catch (e) {
      AppLogger().e("Error updating marks: $e");
    }
  }

  Future<Stream<DocumentSnapshot>> getDocument(
      String collection, String id) async {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .snapshots();
  }

  final storage = FlutterSecureStorage();

  //store secure data
  Future<void> storeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> getSecureData(String key) async {
    return await storage.read(key: key);
  }

  Future<void> deleteSecureData(String key) async {
    await storage.delete(key: key);
  }

  Future<bool> generatePaymentRecordsForAllStudents() async {
    try {
      String currentMonth = DateTime.now().toIso8601String().substring(0, 7);

      QuerySnapshot studentsSnapshot =
          await _firestore.collection('Students').get();

      for (var studentDoc in studentsSnapshot.docs) {
        String studentId = studentDoc.id;
        Map<String, dynamic> subjects = studentDoc['Subject'];

        for (String subject in subjects.keys) {
          if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(subject)) {
            await _firestore.collection('Payment').add({
              'studentId': studentId,
              'month': currentMonth,
              'subject': subject,
              'isPaid': false,
              'paymentDate': null,
            });
          }
        }
      }

      return true;
    } catch (e) {
      AppLogger().e("Error generating payment records: $e");
      return false;
    }
  }

  Future<bool> generatePaymentRecordsForStudent(String studentId) async {
    try {
      String currentMonth = DateTime.now().toIso8601String().substring(0, 7);

      DocumentSnapshot studentDoc =
          await _firestore.collection('Students').doc(studentId).get();

      if (studentDoc.exists) {
        Map<String, dynamic> subjects = studentDoc['Subject'];

        for (String subject in subjects.keys) {
          if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(subject)) {
            await _firestore.collection('Payment').add({
              'studentId': studentId,
              'month': currentMonth,
              'subject': subject,
              'isPaid': false,
              'paymentDate': null,
            });
          }
        }

        return true;
      } else {
        AppLogger().w("Student document not found.");
        return false;
      }
    } catch (e) {
      AppLogger().e("Error generating payment records: $e");
      return false;
    }
  }

  // Function to update payment status
  Future<bool> updatePaymentStatus({
    required String studentId,
    required String month,
    required String subject,
  }) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Payment')
          .where('studentId', isEqualTo: studentId)
          .where('month', isEqualTo: month)
          .where('subject', isEqualTo: subject)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await _firestore
            .collection('Payment')
            .doc(querySnapshot.docs.first.id)
            .update({
          'isPaid': true,
          'paymentDate': DateTime.now().toString(),
        });

        AppLogger().i("Payment status updated successfully.");
        return true;
      } else {
        AppLogger().w("No payment record found for the given criteria.");
        return false;
      }
    } catch (e) {
      AppLogger().e("Error updating payment status: $e");
      return false;
    }
  }

  // Function to fetch payment records for a student
  Future<List<Map<String, dynamic>>> fetchPaymentRecords() async {
    QuerySnapshot snapshot = await _firestore.collection('Payment').get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> saveAllDataToSQLite() async {
    await _saveCollectionToSQLite('Students');
    await _saveCollectionToSQLite('Teachers');
    await _saveCollectionToSQLite('Schedules');
    await _saveCollectionToSQLite('Payment');
  }

  Future<void> _saveCollectionToSQLite(String collection) async {
    final querySnapshot = await _firestore.collection(collection).get();
    await _syncToSQLite(collection, querySnapshot.docs);
  }

  // Add this method to sync Firestore data to SQLite
  Future<void> _syncToSQLite(
      String collection, List<QueryDocumentSnapshot> docs) async {
    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      data['lastUpdated'] = DateTime.now().millisecondsSinceEpoch;

      switch (collection) {
        case 'Students':
          await _sqliteHelper.insertStudent(data);
          break;
        case 'Teachers':
          await _sqliteHelper.insertTeacher(data);
          break;
        case 'Schedules':
          await _sqliteHelper.insertSchedule(data);
          break;
        case 'Payment':
          await _sqliteHelper.insertPayment(data);
          break;
      }
    }
  }
}
