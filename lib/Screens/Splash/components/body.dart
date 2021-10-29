import 'package:code_edu/Screens/Onboarding/on_boarding_screen.dart';
import 'package:code_edu/Screens/Welcome/welcome_screen.dart';
import 'package:code_edu/blocs/auth_bloc_facebook.dart';
import 'package:code_edu/blocs/auth_bloc_google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenView(
        navigateRoute: (FirebaseAuth.instance.currentUser == null || AuthGoogleBloc().currentUser == null || AuthBlocFacebook().currentUser == null) ? Onboarding() : WelcomeScreen(),
        duration: 5000,
        imageSize: 130,
        imageSrc: "assets/images/icon-app.png",
        text: "Code Edu",
        textType: TextType.ColorizeAnimationText,
        textStyle: TextStyle(
          fontSize: 40
        ),
        colors: [
          Colors.purple,
          Colors.blue,
          Colors.yellow,
          Colors.red,
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}