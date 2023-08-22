// Global imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Local imports
// actions and services
import '../actions/auth/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // sign out user Method
  void SignOut() {
    // get Auth Service
    final authService = Provider.of<AuthService>(context , listen:false);
    authService.SignOut();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: SignOut, 
            icon: const Icon(Icons.logout),
            ),
        ], 
      ),
    );
  }
}