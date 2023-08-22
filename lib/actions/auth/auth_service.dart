import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier{
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // sign User in 
  Future<UserCredential> signInWithEmailandPassword( // Future is bascially a promise as of react
    String email, String password  ) async{
      try {
        UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, 
          password: password,
          );
          return userCredential;

      } on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
  }


  // Register new User ; User Create
  Future<UserCredential> signUpWithEmailandPassword( // Future is bascially a promise as of react
    String email, String password) async{
      try {
        UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, 
          password: password,
          );
          return userCredential;

      } on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
    }
  // sign user out 
  Future<void> SignOut() async{
    return await FirebaseAuth.instance.signOut();
  }
}