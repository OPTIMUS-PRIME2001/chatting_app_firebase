import 'package:chatting_app_firebase/actions/message/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatPage({
    super.key, 
    required this.receiverUserEmail , 
    required this.receiverUserID
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // message controller
  final TextEditingController _messageController = TextEditingController();
  // instance of chat_service
  final ChatService _chatService = ChatService();
  // instance of OAuth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //instance of FireStore

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
    );
  }
}