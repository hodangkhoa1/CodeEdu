import 'package:code_edu/Screens/Welcome/components/body.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeName = "/welcomeScreen";
  final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        isDarkMode: isDarkMode,
      ),
    );
  }
}