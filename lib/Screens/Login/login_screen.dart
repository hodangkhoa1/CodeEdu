import 'package:code_edu/Screens/Login/components/body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final bool isDarkMode;

  const LoginScreen({
    Key key,
    @required this.isDarkMode
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        isDarkMode: isDarkMode,
      ),
    );
  }
}
