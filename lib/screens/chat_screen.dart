import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //instance of our cloud firestore
  final messageTextEditingController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  
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
              //Implement logout functionality
              _auth.signOut();
              Navigator.pop(context);
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
            MessageStream(),
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
                      controller: messageTextEditingController,
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
                      messageTextEditingController.clear();
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

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
              //The Stream is actually where the data is coming from
              stream: _firestore.collection('messages').snapshots(), 
              builder: (context, snapshot) {
                // we first check if the snapshot is empty
                if(snapshot.hasData) {
                  //The asych snapshot contains a query snapshot from the cloud firestore,we access the querysnapshot through the data property and then access the docs property!
                  final messages = snapshot.data?.docs.reversed;
                  List<MessageBubble> messageBubbles = [];
                    //This is use to loop through the data gotten from the cloud firestore
                    for (var message in messages!) {
                      final messageText = message.get('text');
                      final messageSender = message.get('sender');

                      final currentUser = loggedInUser?.email;

                      if (currentUser == messageSender){
                        //This means the message is going to from the login user
                      }

                      final messageBubble = MessageBubble(
                        sender: messageSender, 
                        text: messageText,
                        isMe: currentUser == messageSender,
                        );
                      messageBubbles.add(messageBubble);
                    }
                    return Expanded(
                      child: ListView(
                        reverse: true,
                        children: messageBubbles,
                        ),
                    );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              
       );
  }
}


class MessageBubble extends StatelessWidget {

  MessageBubble({required this.sender, required this.text, required this.isMe});
  
  final String sender;
  final String text;
  final loggedInUser = FirebaseAuth.instance.currentUser;
  bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender , style: const TextStyle(
            fontSize: 8.0,
            color: Color.fromARGB(137, 62, 61, 61),
          )),
          Material(
            borderRadius: isMe ? const BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ) : const BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)


            ),
            elevation: 20,
            color: isMe ? Colors.lightBlue : Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: Text(text, style: TextStyle(
                          fontSize: sender == loggedInUser!.email ? 12.0 : 8.0,
                          color: isMe ? Colors.white : Colors.black,
                          )
                          ),
            ),
          ),
        ],
      ),
    );
  }
}