import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/Screens/Login/login_screen.dart';
import 'package:code_edu/Screens/Signup/signup_screen.dart';
import 'package:code_edu/Screens/Welcome/components/background.dart';
import 'package:code_edu/Screens/home/home_screen.dart';
import 'package:code_edu/blocs/auth_bloc_facebook.dart';
import 'package:code_edu/blocs/auth_bloc_google.dart';
import 'package:code_edu/components/display_toast_message.dart';
import 'package:code_edu/components/rounded_button.dart';
import 'package:code_edu/data/facebookAccount.dart';
import 'package:code_edu/data/googleAccount.dart';
import 'package:code_edu/data/user.dart';
import 'package:code_edu/main.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class Body extends StatefulWidget {
  final bool isDarkMode;

  const Body({
    Key key,
    @required this.isDarkMode
  }) : super(key: key);
  
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
                  speed: Duration(milliseconds: 100),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: Colors.blueAccent
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            FadeTransition(
              opacity: _animationController,
              child: Lottie.asset(
                "assets/images/46837-welcome.json",
                height: size.height * 0.4,
                controller: _welcomeController,
                onLoaded: (composition) {
                  _welcomeController..duration = composition.duration..repeat(
                    reverse: true
                  );
                },
              ),
            ),
            SizedBox(height: size.height * 0.05),
            FadeTransition(
              opacity: _animationController,
              child: RoundeButton(
                text: AppLocalizations.of(context).login,
                press: () async {
                  if(isoffline == false) {
                    if(user != null) {
                      QuerySnapshot snapshotUser = await FirebaseFirestore.instance.collection('users').get();
                      QuerySnapshot snapshotGoogle = await FirebaseFirestore.instance.collection('googleAccounts').get();
                      QuerySnapshot snapshotFacebook = await FirebaseFirestore.instance.collection('facebookAccounts').get();
                      snapshotUser.docs.forEach((snapValueUser) {
                        if(snapValueUser != null) {
                          OurUserDetail ourUserDetail = OurUserDetail.fromMap(snapValueUser.data());
                          if(ourUserDetail.uid == user.uid) {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
                              urlImage: ourUserDetail.urlImage,
                              nameUser: ourUserDetail.fullName,
                              nameUniversity: ourUserDetail.nameUniversity,
                              emailUser: ourUserDetail.email,
                              phoneNumber: ourUserDetail.phoneNumber,
                              showBottomBar: ourUserDetail.enroll,
                              uid: ourUserDetail.uid,
                              dateOfBirth: ourUserDetail.dateOfBirth.toDate(),
                            )), (Route<dynamic> route) => false);
                            displayToastMessage(context, AppLocalizations.of(context).loginByUserAccount);
                          } else {
                            snapshotGoogle.docs.forEach((snapValueGoogle) {
                              if(snapValueGoogle != null) {
                                OurGoogleDetail ourGoogleDetail = OurGoogleDetail.fromMap(snapValueGoogle.data());
                                if(ourGoogleDetail.uid == user.uid) {
                                  AuthGoogleBloc().currentUser.listen((googleUser) {
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
                                      urlImage: googleUser.photoURL,
                                      nameUser: googleUser.displayName,
                                      nameUniversity: ourGoogleDetail.nameUniversity,
                                      emailUser: googleUser.email != null ? googleUser.email : (ourGoogleDetail.email != null ? ourGoogleDetail.email : ""),
                                      phoneNumber: ourGoogleDetail.phoneNumber != null ? ourGoogleDetail.phoneNumber : "",
                                      showBottomBar: ourGoogleDetail.enroll,
                                      uid: googleUser.uid,
                                      dateOfBirth: ourGoogleDetail.dateOfBirth.toDate(),
                                    )), (Route<dynamic> route) => false);
                                    displayToastMessage(context, AppLocalizations.of(context).loginByGoogle);
                                  });
                                } else {
                                  snapshotFacebook.docs.forEach((snapValueFacebook) {
                                    if(snapValueFacebook != null) {
                                      OurFacebookDetail ourFacebookDetail = OurFacebookDetail.fromMap(snapValueFacebook.data());
                                      if(ourFacebookDetail.uid == user.uid) {
                                        AuthBlocFacebook().currentUser.listen((facebookUser) {
                                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
                                            urlImage: facebookUser.photoURL,
                                            nameUser: facebookUser.displayName,
                                            nameUniversity: ourFacebookDetail.nameUniversity,
                                            emailUser: ourFacebookDetail.email != null ? ourFacebookDetail.email : "",
                                            phoneNumber: ourFacebookDetail.phoneNumber != null ? ourFacebookDetail.phoneNumber : "",
                                            showBottomBar: ourFacebookDetail.enroll,
                                            uid: facebookUser.uid,
                                            dateOfBirth: ourFacebookDetail.dateOfBirth.toDate(),
                                          )), (Route<dynamic> route) => false);
                                          displayToastMessage(context, AppLocalizations.of(context).loginByFacebook);
                                        });
                                      }
                                    }
                                  });
                                }
                              }
                            });
                          }
                        }
                      });
                    } else {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginScreen(
                        isDarkMode: widget.isDarkMode,
                      )), (route) => false);
                    }
                  } else {
                    displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
                  }
                },
                color: widget.isDarkMode ? Color(0xFF969696) : Colors.blue,
              ),
            ),
            user == null ? FadeTransition(
              opacity: _animationController,
              child: RoundeButton(
                text: AppLocalizations.of(context).signUp,
                color: widget.isDarkMode ? Color(0xFF313131) : Color.fromARGB(130, 30, 144, 255),
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
            ) : Container(),
          ],
        ),
      ),
    );
  }
}