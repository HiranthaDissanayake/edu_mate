import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
        print(e);
      }
    }
    return null;
  }

  Future<User?> loginEmailAndPasswordForStudent(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> loginUser(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("User logged in: ${userCredential}");

    if (userCredential.user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();
          print("User document: $userDoc");

      if (userDoc.exists) {
        return true; 
      }
    }
    return false; 
  } catch (e) {
    print("Login error: $e");
    return false; 
  }
}

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
        return null; // If role is not recognized
      }
    } else {
      return null; // No user found
    }
  } catch (e) {
    print("Error fetching user role: $e");
    return null;
  }
}

}