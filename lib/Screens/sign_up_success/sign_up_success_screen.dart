import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/Screens/sign_up_success/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SignUpSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("SignUp Success"),
      ),
      body: Body(
        isDarkMode: isDarkMode,
      ),
    );
  }
}