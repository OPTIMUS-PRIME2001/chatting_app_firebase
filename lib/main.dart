import 'package:chatting_app_firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Local imports
// service / actions files
import 'package:chatting_app_firebase/actions/auth/auth_route.dart';
import 'package:chatting_app_firebase/actions/auth/auth_service.dart';

// components
// import 'pages/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    //Wrapping to get access to information inside context within the widget tree at any point
    ChangeNotifierProvider(
      create: (context)=> AuthService(),
      child: const MainApp(),
      ),
  );
}

class MainApp extends StatelessWidget {  
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthRoute(),
    );
  }
}