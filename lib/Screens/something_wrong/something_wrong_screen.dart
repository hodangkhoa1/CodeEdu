import 'package:flutter/material.dart';

class SomethingWrongScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/5_Something Wrong.png",
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}