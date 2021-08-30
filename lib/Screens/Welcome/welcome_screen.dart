import 'package:code_edu/Screens/Welcome/components/body.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeName = "/welcomeScreen";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}