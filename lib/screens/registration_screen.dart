import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});
  static const String id = 'registration_screen';

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
                height: 50,
                label: "Email",
                value: "",
                onChanged: (value) {},
                placeholder: "Enter your email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              child: CustomTextField(
                height: 50,
                label: "Password",
                value: "",
                onChanged: (value) {},
                placeholder: "Enter your password",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: CustomElevatedButton(onPressed: () {}, text: "Login", backgroundColor: AppColors.primaryColor,),
            ),
          ],
        ),
      ),
    );
  }
}