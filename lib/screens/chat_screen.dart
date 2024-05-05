import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //instance of our cloud firestore
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  late String messageText;

   @override
   void initState() {
    super.initState();

    getCurrentUser();

   }
// This method is used to get the current user that is logged in or check if the user is logged in
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }
  //This is not a good method because we always have to pull data from the cloud firestore
  // void getMessages() async {
  //   //This is use to get the data from the cloud firestore
  //   final messages = await _firestore.collection('messages').get();
  //   //This is use to loop through the data gotten from the cloud firestore
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  void messagesStream() async {
    //This is use to get the data from the cloud firestore
    //NB The snapshot is a stream of data gotten from the cloud firestore
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      //This is use to loop through the data gotten from the cloud firestore
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              messagesStream();
              //Implement logout functionality
              // _auth.signOut();
              // Navigator.pop(context);
            },
          ),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              //The Stream is actually where the data is coming from
              stream: _firestore.collection('messages').snapshots(), 
              builder: (context, snapshot) {
                // we first check if the snapshot is empty
                if(snapshot.hasData) {
                  //The asych snapshot contains a query snapshot from the cloud firestore,we access the querysnapshot through the data property and then access the docs property!
                  final messages = snapshot.data?.docs;
                  List<Text> messageWidgets = [];
                    //This is use to loop through the data gotten from the cloud firestore
                    for (var message in messages!) {
                      final messageText = message.get('text');
                      final messageSender = message.get('sender');
                      final messageWidget = Text('$messageText from $messageSender');
                      messageWidgets.add(messageWidget);
                    }
                    return Column(
                  children: messageWidgets,
                );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              
              ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //messageText + loggedInUser.email
                      //This basically sends the message to the cloud firestore
                     _firestore.collection('messages').add({
                       'text': messageText,
                       'sender': loggedInUser!.email,
                     });
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),

            )
            
          ],
        ),
      ),
    );
  }
}