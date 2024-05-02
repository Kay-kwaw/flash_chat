import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;
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
              child: CustomElevatedButton(onPressed: () {
                print(email);
                print(password);
              }, text: "Login", backgroundColor: AppColors.primaryColor,),
            ),
          ],
        ),
      ),
    );
  }
}