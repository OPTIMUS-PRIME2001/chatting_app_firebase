import 'package:chatting_app_firebase/pages/login_page.dart';
import 'package:chatting_app_firebase/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially show the login screen
  bool showLoginPage = true;

  // function to toggle between login and register page
  void togglePages(){
    // Simple toggling Logic
    setState((){
      showLoginPage = !showLoginPage;
    });
  }//end

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(onTap: togglePages);
    }
    else{
      return RegisterPage(onTap: togglePages,);
    }
  }
}