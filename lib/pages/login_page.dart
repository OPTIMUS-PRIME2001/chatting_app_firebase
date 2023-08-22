import 'package:chatting_app_firebase/actions/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Components
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';


class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  //SignIn User Functionality Service
  void SignIn() async{
    // get the auth service
    final authService = Provider.of<AuthService>(context , listen:false);
    try{
      await authService.signInWithEmailandPassword(
        emailController.text, passwordController.text
        );
    }catch(e){
      // any error occur we going to show by SnackBar 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            // Set Some Padding
            padding: const EdgeInsets.symmetric(horizontal: 25.0),

            child: Column(
              children: [
                const SizedBox(height: 100.0),

                //Logo
                Icon(
                  Icons.message,
                  size: 100,
                  color: Colors.grey[800],
                ),

                const SizedBox(height: 50.0,),
                
                //Welcome Message
                const Text(
                  "Welcome Back You\'ve been missed",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          
                const SizedBox(height: 25.0,),


                //email textfield
                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 10.0,),


                //password textfield
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                
                const SizedBox(height: 25.0,),

                // signIn button
                CustomButton(onTap: SignIn, 
                  buttonText: "Sign In",
                ),
                const SizedBox(height: 50),

                //not a member regiter now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a Member?",
                      style: TextStyle(color: Colors.black,),
                    ),

                    const SizedBox(width: 4,),

                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text("Register Now", 
                        style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                       ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
