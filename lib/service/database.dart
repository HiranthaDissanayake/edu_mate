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
  Future setClassSchedule(Map<String,dynamic>scheduleMap , String id) async{
    return await FirebaseFirestore.instance
    .collection("Schedules")
    .doc(id)
    .set(scheduleMap);

  }

  // Fetch all Student details
  Future<Stream<QuerySnapshot>> getStudents() async{
    return await FirebaseFirestore.instance.collection("Students").snapshots();
  }

  // Fetch all Teachers details
  Future<Stream<QuerySnapshot>> getTeachers() async{
    return await FirebaseFirestore.instance.collection("Teachers").snapshots();
  }
  
}
