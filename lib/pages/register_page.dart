import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Components
import '../actions/auth/auth_service.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //SignUp User Functionality Service
  void SignUp() async{
    // get the auth service
    final authService = Provider.of<AuthService>(context , listen:false);
    try{
      await authService.signUpWithEmailandPassword(
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
                const SizedBox(height: 80.0),

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

                //name textfield
                CustomTextField(
                  controller: nameController,
                  hintText: "Name",
                  obscureText: false,
                ),

                const SizedBox(height: 10.0,),

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
                CustomButton(onTap: SignUp, 
                  buttonText: "Sign Up",
                ),
                const SizedBox(height: 50),

                //not a member regiter now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already a Member?",
                      style: TextStyle(color: Colors.black,),
                    ),

                    const SizedBox(width: 4,),

                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text("LogIn Now", 
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
