import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

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
            Row(
              children: [
                SizedBox(
                  height: 60.0,
                  child: Image.asset("assets/logo.png"),
                ),
                const Text('We Chat', style: TextStyle(
                  fontSize: 45,
                  color: Colors.black
                ))
              ],
            )
          ],
        )),
    );
  }
}