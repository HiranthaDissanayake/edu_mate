import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/Screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

// create user with email and password
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
// login user with email and password
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

  
  //login user with email and password
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
  
//logout
  Future<void> logout(BuildContext context ,String role) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear(); 

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Loginscreen(role: role,)));
}
}
