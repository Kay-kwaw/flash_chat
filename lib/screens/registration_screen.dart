import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //authentication instance using firebase, and we use final because we are never going to change it, so this instance is basically to authenticate users.
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool isLoading = false; 



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 150.0,
                child: Image.asset("assets/logo.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0),
              child: CustomTextField(
                keyboardType: TextInputType.emailAddress,
                height: 50,
                label: "Email",
                value: "",
                onChanged: (value) {
                  email = value;
                },
                placeholder: "Enter your email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              child: CustomTextField(
                obscureText: true,
                height: 50,
                label: "Password",
                value: "",
                onChanged: (value) {
                  password = value;
                },
                placeholder: "Enter your password",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: isLoading ? const CircularProgressIndicator() // Show CircularProgressIndicator when loading
                : CustomElevatedButton(onPressed: () async {
                  // print(email);
                  // print(password);
                  //In order to register the user, we tap into the _auth instance created. Now the createUserWithEmailandPassword returns a future so we encapsulate it with a final
                  //NB. this can fail so we wrap it with the try and catch
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } catch(e){
                    if (kDebugMode) {
                      print(e);
                    }
                  }
                  
                
                }, text: "Register", backgroundColor: AppColors.primaryColor,),
              ),
              // Padding(),
          ],
        ),
      ),
    );
  }
}