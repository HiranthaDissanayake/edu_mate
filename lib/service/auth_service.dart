
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService{
  final _auth = FirebaseAuth.instance;
Future<User?>crateEmailAndPasswordForStudent(String email,String password)async{
  try{
  final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  return userCredential.user;}
  catch(e){
    if (kDebugMode) {
      print(e);
    }
  }
  return null;
} 
Future<User?>loginEmailAndPasswordForStudent(String email,String password)async{
  try{
  final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
  return userCredential.user;}
  catch(e){
    if (kDebugMode) {
      print(e);
    }
  }
  return null;
} 
  Future<void> signOut() async {
    try{
      await _auth.signOut();

    }
    catch(e){
    if (kDebugMode) {
      print(e);
    }
    }
  }
}