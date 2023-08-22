//Global imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Local imports
//pages and ui components
import '../../pages/home_page.dart';
//actions
import '../../actions/login_or_register.dart';


// This file contains the logic , if sessions exist where to Redirect 
//if no session from the context then stay in the loginPage
class AuthRoute extends StatelessWidget {
  const AuthRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if(snapshot.hasData){
            return const HomePage();
          }

          // user is NOT logged in
          else{
            return const LoginOrRegister();
          }
        }
      ),
    );
  }
}