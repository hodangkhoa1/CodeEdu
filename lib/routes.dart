import 'package:code_edu/Screens/Login/login_screen.dart';
import 'package:code_edu/Screens/Signup/signup_screen.dart';
import 'package:code_edu/Screens/Splash/splash_screen.dart';
import 'package:code_edu/Screens/Welcome/welcome_screen.dart';
import 'package:code_edu/Screens/forgot_password/forgot_password_screen.dart';
import 'package:code_edu/Screens/help_center/help_center.dart';
import 'package:code_edu/Screens/otp/otp_screen.dart';
import 'package:code_edu/Screens/policy_terms_screen/policy_screen.dart';
import 'package:code_edu/Screens/questions_screen/questions_screen.dart';
import 'package:code_edu/Screens/software_information/software_information.dart';
import 'package:code_edu/Screens/update/update_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HelpCenter.routeName: (context) => HelpCenter(),
  PolicyScreen.routeName: (context) => PolicyScreen(),
  QuestionsScreen.routeName: (context) => QuestionsScreen(),
  UpdateScreen.routeName: (context) => UpdateScreen(),
  SoftwareInformation.routeName: (context) => SoftwareInformation(),
};