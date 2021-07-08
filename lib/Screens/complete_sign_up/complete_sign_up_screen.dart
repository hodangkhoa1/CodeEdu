import 'package:code_edu/Screens/complete_sign_up/components/body.dart';
import 'package:flutter/material.dart';

class CompleteSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Body(),
    );
  }
}