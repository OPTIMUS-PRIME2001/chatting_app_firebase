import 'package:chatting_app_firebase/actions/message/chat_service.dart';
import 'package:chatting_app_firebase/components/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Components
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';

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


  //Method for Send Messages
  void sendMessage() async {
    if (_messageController.text.isNotEmpty){
      // only send message if there is something to send
      await _chatService.sendMessage(
        widget.receiverUserID , _messageController.text
      );

      // clear the text controller after sending the message
      _messageController.clear();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(
        children: [
          //messages
          Expanded(
            child: _buildMessageList(),
          ),

          //user Input
          _buildMessageInput(),
        ],
      ),
    );
  }

  // build message List
  Widget _buildMessageList(){
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverUserID , _firebaseAuth.currentUser!.uid
      ), 
      builder: (context , snapshot) {
        // if error occured
        if(snapshot.hasError){
          return Text('Error${snapshot.error}');
        }

        // on Loading
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading..');
        }

        // return List View
        return ListView(
          children: snapshot.data!.docs
          .map((document) => _buildMessageItem(document))
          .toList(),
        );
      }
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align the message to the right if the sender is the currentUser , otherwise left
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid) 
    ? Alignment.centerRight
    : Alignment.centerLeft ;


    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid) 
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            ChatBubble(message: data['message']),
          ]
          ),
      ),
    );
  }

  // build message input
  Widget _buildMessageInput(){
    return Row(
      children: [
        // textfield
        Expanded(
          child: CustomTextField(
            controller: _messageController,
            hintText: "Enter message",
            obscureText: false,
          ),
        ),

        //send button
        IconButton(
          icon : const Icon(Icons.arrow_upward, size:40), 
          onPressed:sendMessage,
        ),
      ],
    );
  }

}