import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier{
  // instance of Oauth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance for firestore database
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;  

  // sign User in 
  Future<UserCredential> signInWithEmailandPassword( // Future is bascially a promise as of react
    String email, String password  ) async{
      try {
        UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, 
          password: password,
          );

          //add new document for user in users collection if doesn't exist in case of signIn
          _fireStore.collection('users').doc(userCredential.user!.uid).set({
            'uid': userCredential.user!.uid,
            'email':email,
            'emailVerified':userCredential.user!.emailVerified,
          }, SetOptions(merge: true));


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

          //After Registering New User
          // Create a new document for the user in the users collection
          _fireStore.collection('users').doc(userCredential.user!.uid).set({
              //fields
              'uid': userCredential.user!.uid,
              'email':email,
              'emailVerified':userCredential.user!.emailVerified
          });

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