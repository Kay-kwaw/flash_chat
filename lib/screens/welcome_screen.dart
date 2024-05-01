import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 60.0,
                      child: Image.asset("assets/logo.png"),
                    ),
                  ),
                  const Text('We Chat', style: TextStyle(
                    fontSize: 45,
                    color: Colors.black
                  ))
                ],
              ),
            ),
            Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: CustomElevatedButton(onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            }, text: "Login", backgroundColor: AppColors.hintColor,),
            ),
            Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomElevatedButton(onPressed: () {}, text: "Register", backgroundColor: AppColors.primaryColor,),
            ),
             
          ],
        )),
    );
  }
}