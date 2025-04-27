import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/service/app_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createEmailAndPasswordForStudent(
      String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        AppLogger().e(e);
      }
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        AppLogger().e(e);
      }
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      AppLogger().i("User logged in: $userCredential");

      if (userCredential.user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .get();
        AppLogger().d("User document: $userDoc");

        if (userDoc.exists) {
          return true;
        }
      }
      return false;
    } catch (e) {
      AppLogger().e("Login error: $e");
      return false;
    }
  }
}
