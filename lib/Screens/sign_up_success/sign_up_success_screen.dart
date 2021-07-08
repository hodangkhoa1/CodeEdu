import 'package:code_edu/Screens/sign_up_success/components/body.dart';
import 'package:flutter/material.dart';

class SignUpSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("SignUp Success"),
      ),
      body: Body(),
    );
  }
}