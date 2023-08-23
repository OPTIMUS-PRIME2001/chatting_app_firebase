// Global imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Local imports
import '../../collection/message.dart';

class ChatService extends ChangeNotifier {
  // get instance of Oauth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  // get instance of Firebase
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // SEND MESSAGE
  Future<void> sendMessage(String receiverId , String message) async{
    //get CurrentUser
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timeStamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderId: currentUserId, 
      senderEmail: currentUserEmail, 
      receiverId: receiverId, 
      timeStamp: timeStamp, 
      message: message,
      );


    //construct chat room id from current user id and receive
    List<String> ids = [currentUserId , receiverId];   
      // sort this ids ( this ensures the chat room id is always the same for any pair of people)
      ids.sort();
      String chatRoomId = ids.join("_");  // combine the ids into a single string to use as a chatRoomID;

      // add new message to database
      await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());

  }
  // GET MESSAGE
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId){
  //construct chat room id from user ids (sorted to ensure it matches the id used when sending message)
  List<String> ids = [userId, otherUserId];
  ids.sort();
  String chatRoomId = ids.join("-");

  return _fireStore
     .collection('chat_rooms')
      .doc(chatRoomId)
      .collection('messages')
      .orderBy('timestamp',  descending:false).snapshots();
  }
}