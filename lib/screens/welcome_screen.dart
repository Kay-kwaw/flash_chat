import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}
//This is the state object
class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  AnimationController? controller;

  @override 
  void initState() {
    super.initState();
    
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      //The vsync is where we provide the ticker provider and it is most the state object
      vsync: this,
      //This is use to reference the state object
    );
  }
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
            child: CustomElevatedButton(onPressed: () {
               Navigator.pushNamed(context, RegistrationScreen.id);
            }, text: "Register", backgroundColor: AppColors.primaryColor,),
            ),
             
          ],
        ),
        
        ),
    );
  }
}