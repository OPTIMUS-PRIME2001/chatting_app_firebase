// Global imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Local imports
// actions and services
import '../actions/auth/auth_service.dart';
import '../pages/chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //display all our users in our app from the auth instance
  // instance of Oauth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


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

      body: _buildUserList(),
    );
  }


  //build custom Widget here 
    //build a list of users except for the current user in the session
    Widget _buildUserList(){
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot){
          // if has error
          if(snapshot.hasError){
            return const Text('Error');
          }
          //Loading
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child : CircularProgressIndicator());
            // return const Text('Loading..');
          }

          //List all User
            return ListView(
              children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
            );

        }, 
      );
    }

    //build individual user list Item
    Widget _buildUserListItem(DocumentSnapshot document){ 
      //Map format
      Map<String,dynamic> data = document.data()! as Map<String, dynamic>;

      //display all users except  the current User
      //check by auth
      if(_firebaseAuth.currentUser!.email != data['email']){  
          return ListTile(
            title: Text(data['email']),
            onTap: (){
              //redirect the selected/clicked user UID to the chat page/room
              Navigator.push(context , 
                MaterialPageRoute(builder: (context) => ChatPage(
                  receiverUserEmail: data['email'],
                  receiverUserID: data['uid'],
                  ),
                ),
              );//Navigator
            }, //onTap            
          );
      }// end of if
      else {
        return Container();
      }
    }

}