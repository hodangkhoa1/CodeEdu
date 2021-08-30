import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:code_edu/AllWidgets/display_toast_message.dart';
import 'package:code_edu/Screens/Login/login_screen.dart';
import 'package:code_edu/Screens/Signup/signup_screen.dart';
import 'package:code_edu/Screens/Welcome/components/background.dart';
import 'package:code_edu/Screens/home/home_screen.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/components/rounded_button.dart';
import 'package:code_edu/main.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _welcomeController;
  StreamSubscription internetconnection;
  bool isoffline = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1000
      )
    );
    Timer(Duration(milliseconds: 200), () => _animationController.forward());
    super.initState();
    internetconnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.none){
        setState(() {
          isoffline = true;
        });
      }else if(result == ConnectivityResult.mobile){
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        setState(() {
          isoffline = false;
        });
      }
    });
    _welcomeController = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _welcomeController.dispose();
    internetconnection.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TypewriterAnimatedText(
                  AppLocalizations.of(context).welcomeToCodeEdu,
                  speed: Duration(
                    milliseconds: 100
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: Colors.blueAccent
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            FadeTransition(
              opacity: _animationController,
              child: Lottie.network(
                "https://assets9.lottiefiles.com/packages/lf20_kltum0us.json",
                height: size.height * 0.4,
                controller: _welcomeController,
                onLoaded: (composition) {
                  _welcomeController..duration = composition.duration..repeat(
                    reverse: true
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            FadeTransition(
              opacity: _animationController,
              child: RoundeButton(
                text: AppLocalizations.of(context).login,
                press: () {
                  if(isoffline == false) {
                    setState(() {
                      if(googleRef != null) {
                        googleRef.listen((googleUser) {
                          if(googleUser != null){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
                              urlImage: googleUser.photoURL,
                              nameTextAppBar: googleUser.displayName,
                              emailGoogleLogin: googleUser.email,
                              showBottomBar: "false",
                            )), (Route<dynamic> route) => false);
                            displayToastMessage(context, AppLocalizations.of(context).loginByGoogle);
                          }
                        });
                      } else if(facebookRef != null) {
                        facebookRef.listen((facebookUser) {
                          if(facebookUser != null) {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
                              urlImage: facebookUser.photoURL,
                              nameTextAppBar: facebookUser.displayName,
                              emailGoogleLogin: facebookUser.email,
                              showBottomBar: "false",
                            )), (Route<dynamic> route) => false);
                            displayToastMessage(context, "Bạn đăng nhập bằng facebook");
                          }
                        });
                      }
                      // else if(userRef != null) {
                      //   userRef.child(FirebaseAuth.instance.currentUser.uid).once().then((DataSnapshot snap) {
                      //     if(snap != null) {
                      //       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
                      //         urlImage: snap.value['urlImage'].toString(),
                      //         nameTextAppBar: snap.value['name'].toString(),
                      //         emailGoogleLogin: snap.value['email'].toString(),
                      //         showBottomBar: snap.value['enroll'].toString(),
                      //       )), (Route<dynamic> route) => false);
                      //       displayToastMessage(context, AppLocalizations.of(context).loginByUserAccount);
                      //       }
                      //   });
                      // }
                      if(FirebaseAuth.instance.currentUser == null || googleRef == null || facebookRef == null) {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginScreen(
                          isDarkMode: isDarkMode,
                        )), (route) => false);
                      }
                    });
                  } else {
                    displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
                  }
                },
                color: isDarkMode ? Color(0xFF969696) : Colors.blue,
              ),
            ),
            FadeTransition(
              opacity: _animationController,
              child: RoundeButton(
                text: AppLocalizations.of(context).signUp,
                color: isDarkMode ? Color(0xFF313131) : Color.fromARGB(130, 30, 144, 255),
                textColor: Colors.white,
                press: () {
                  if(isoffline == false) {
                    setState(() {
                      Navigator.of(context).pushNamedAndRemoveUntil(SignUpScreen.routeName, (Route<dynamic> route) => false);
                    });
                  } else {
                    displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}