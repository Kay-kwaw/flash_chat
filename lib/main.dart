import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter is initialized
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyC9cyPfO4lSgUcptHBFrgrrQbuMdHSTdIE",
        authDomain: "we-chat-ce520.firebaseapp.com",
        projectId: "we-chat-ce520",
        storageBucket: "we-chat-ce520.appspot.com",
        messagingSenderId: "66317649471",
        appId: "1:66317649471:web:2a73dad7caf3cc01881a8a"
    ),
  );
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
      initialRoute: WelcomeScreen.id,
    );
  }
}
