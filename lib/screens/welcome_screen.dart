import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
    //This is use to start the animation and it will start from the beginning and rebuild the widget
    controller!.forward();
    //This is use to listen to the animation and it will rebuild the widget
    controller!.addListener(() {
      setState(() {
        
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                children: [
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: controller!.value * 90.0,
                      child: Image.asset("assets/logo.png"),
                    ),
                  ),
                  AnimatedTextKit(animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),)
                  ])
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