import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  bool isLoading = false; // Track loading state

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
              child: isLoading
                  ? CircularProgressIndicator() // Show CircularProgressIndicator when loading
                  : CustomElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true; // Set loading state to true
                        });
                        try {
                          final alreadyUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if (alreadyUser != null) {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                        } catch (e) {
                          print(e);
                        } finally {
                          setState(() {
                            isLoading = false; // we Reset the loading page
                          });
                        }
                      },
                      text: "Login",
                      backgroundColor: AppColors.hintColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
