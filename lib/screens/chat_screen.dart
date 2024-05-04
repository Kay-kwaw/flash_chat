import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
   User? loggedInUser;

   @override
   void initState() {
    super.initState();

    getCurrentUser();

   }

  void getCurrentUser() async {
     final user = await _auth.currentUser;
     if (user != null) {
     loggedInUser = user;
     print(loggedInUser!.email);
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}