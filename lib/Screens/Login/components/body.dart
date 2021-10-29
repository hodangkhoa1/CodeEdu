import 'dart:async';

import 'package:code_edu/Screens/Login/components/background.dart';
import 'package:code_edu/Screens/Login/function/login_user.dart';
import 'package:code_edu/Screens/Signup/signup_screen.dart';
import 'package:code_edu/Screens/forgot_password/forgot_password_screen.dart';
import 'package:code_edu/components/already_have_an_account_check.dart';
import 'package:code_edu/components/build_form_field_custom.dart';
import 'package:code_edu/components/check_error.dart';
import 'package:code_edu/components/display_toast_message.dart';
import 'package:code_edu/components/form_error.dart';
import 'package:code_edu/components/rounded_button.dart';
import 'package:code_edu/components/show_dialog_error.dart';
import 'package:code_edu/components/social_card.dart';
import 'package:code_edu/functions/login_facebook.dart';
import 'package:code_edu/functions/login_google.dart';
import 'package:code_edu/validators/reg_validator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  final bool isDarkMode;

  const Body({
    Key key,
    @required this.isDarkMode
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<Body> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool _activeShowPass = false;
  final List<String> emailErrors = [];
  final List<String> passwordErrors = [];
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  StreamSubscription internetconnection;
  bool isoffline = false;
  AnimationController _loginController;
  StreamSubscription<User> loginStateSubscription;
  FocusNode emailFieldFocusNode;
  FocusNode passwordFieldFocusNode;

  @override
  void initState() {
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
    _loginController = AnimationController(
      vsync: this,
    );
    super.initState();
    emailFieldFocusNode = FocusNode();
    passwordFieldFocusNode = FocusNode();
    emailFieldFocusNode.addListener(() {
      if (!emailFieldFocusNode.hasFocus) {
        if(emailTextEditingController.text.trim().isEmpty && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail)) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(invalidEmailError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail))) {
          setState(() {
            AppLocalizations.of(context).language == "English" ? emailErrors.add(emailNullError) : emailErrors.add(AppLocalizations.of(context).pleaseEnterYourEmail);
          });
        } else if(!emailValidatorRegExp.hasMatch(emailTextEditingController.text.trim()) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(invalidEmailError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail)) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail))){
          setState(() {
            AppLocalizations.of(context).language == "English" ? emailErrors.add(invalidEmailError) : emailErrors.add(AppLocalizations.of(context).pleaseEnterValidEmail);
          });
        }
      }
    });
    passwordFieldFocusNode.addListener(() {
      if (!passwordFieldFocusNode.hasFocus) {
        if(passwordTextEditingController.text.trim().isEmpty && !(AppLocalizations.of(context).language == "English" ? passwordErrors.contains(passwordNullError) : passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword))) {
          setState(() {
            AppLocalizations.of(context).language == "English" ? passwordErrors.add(passwordNullError) : passwordErrors.add(AppLocalizations.of(context).pleaseEnterYourPassword);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    internetconnection.cancel();
    _loginController.dispose();
    super.dispose();
    emailFieldFocusNode.addListener(() {
      super.dispose();
    });
    passwordFieldFocusNode.addListener(() {
      super.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
            showDialog(
              context: context,
              builder: (_) => CupertinoAlertDialog(
                title: Text(""),
                content: Column(
                  children: [
                    Text("Error "),
                    Positioned(
                      left: 20,
                        right: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 45,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                              child: Image.asset("assets/images/error.png")
                          ),
                        ),
                    ),
                  ],
                ),
                actions: [
                  CupertinoDialogAction(child: Text("OK"),),
                ],
              ),
              barrierDismissible: false,
          );
        }
        if(snapshot.connectionState == ConnectionState.done) {
          return Form(
            key: _formKey,
            child: Background(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).login,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.blue
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Lottie.asset(
                          "assets/images/login.json",
                          height: size.height * 0.30,
                          controller: _loginController,
                          onLoaded: (animation) {
                            _loginController..duration = animation.duration..repeat(
                              reverse: true
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        buildFormFieldCustom(
                          emailErrors,
                          emailFieldFocusNode,
                          1,
                          1,
                          emailTextEditingController,
                          BorderRadius.circular(29),
                          (AppLocalizations.of(context).language == "English" ? (emailErrors.contains(invalidEmailError) || emailErrors.contains(emailNullError)) : (emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail) || emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail))) ? Colors.red : Colors.green,
                          TextInputType.emailAddress,
                          false,
                          email,
                          (value) {
                            if(value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail)) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(invalidEmailError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail))) {
                              setState(() {
                                AppLocalizations.of(context).language == "English" ? emailErrors.remove(emailNullError) : emailErrors.remove(AppLocalizations.of(context).pleaseEnterYourEmail);
                              });
                            } else if(emailValidatorRegExp.hasMatch(value) && (AppLocalizations.of(context).language == "English" ? emailErrors.contains(invalidEmailError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail)) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail))){
                              setState(() {
                                AppLocalizations.of(context).language == "English" ? emailErrors.remove(invalidEmailError) : emailErrors.remove(AppLocalizations.of(context).pleaseEnterValidEmail);
                              });
                            }
                            email = value;
                            return null;
                          },
                          (value) {
                            if(value.isEmpty && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail)) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(invalidEmailError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail))) {
                              setState(() {
                                AppLocalizations.of(context).language == "English" ? emailErrors.add(emailNullError) : emailErrors.add(AppLocalizations.of(context).pleaseEnterYourEmail);
                              });
                            } else if(!emailValidatorRegExp.hasMatch(value) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(invalidEmailError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail)) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail))){
                              setState(() {
                                AppLocalizations.of(context).language == "English" ? emailErrors.add(invalidEmailError) : emailErrors.add(AppLocalizations.of(context).pleaseEnterValidEmail);
                              });
                            }
                            return null;
                          },
                          AppLocalizations.of(context).yourEmail,
                          Icons.email_outlined,
                          (AppLocalizations.of(context).language == "English" ? (emailErrors.contains(invalidEmailError) || emailErrors.contains(emailNullError)) : (emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail) || emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail))) ? Colors.red : Colors.green,
                          (emailTextEditingController.text.trim().isNotEmpty || emailErrors.isNotEmpty)
                          ? ((AppLocalizations.of(context).language == "English" ? (emailErrors.contains(invalidEmailError) || emailErrors.contains(emailNullError)) : (emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail) || emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail))) ? Icon(
                            Icons.error_outline,
                            size: 26,
                            color: Colors.red,
                          ) : Icon(
                            Icons.check,
                            size: 26,
                            color: Colors.green,
                          ))
                          : null,
                        ),
                        FormError(errors: emailErrors),
                        buildFormFieldCustom(
                          passwordErrors,
                          passwordFieldFocusNode,
                          1,
                          1,
                          passwordTextEditingController,
                          BorderRadius.circular(29),
                          (AppLocalizations.of(context).language == "English" ? passwordErrors.contains(passwordNullError) : passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword)) ? Colors.red : Colors.green,
                          TextInputType.visiblePassword,
                          !_activeShowPass,
                          password,
                          (value) {
                            if(value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? passwordErrors.contains(passwordNullError) : passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword))) {
                              setState(() {
                                AppLocalizations.of(context).language == "English" ? passwordErrors.remove(passwordNullError) : passwordErrors.remove(AppLocalizations.of(context).pleaseEnterYourPassword);
                              });
                            }
                            password = value;
                            return null;
                          },
                          (value) {
                            if(value.isEmpty && !(AppLocalizations.of(context).language == "English" ? passwordErrors.contains(passwordNullError) : passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword))) {
                              setState(() {
                                AppLocalizations.of(context).language == "English" ? passwordErrors.add(passwordNullError) : passwordErrors.add(AppLocalizations.of(context).pleaseEnterYourPassword);
                              });
                            }
                            return null;
                          },
                          AppLocalizations.of(context).yourPassword,
                          Icons.lock,
                          (AppLocalizations.of(context).language == "English" ? passwordErrors.contains(passwordNullError) : passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword)) ? Colors.red : Colors.green,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: onToggleShowPass,
                                child: Icon(
                                  _activeShowPass ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 6),
                              (passwordTextEditingController.text.trim().isNotEmpty || passwordErrors.isNotEmpty)
                              ? ((AppLocalizations.of(context).language == "English" ? passwordErrors.contains(passwordNullError) : passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword)) ? Icon(
                                Icons.error_outline,
                                size: 26,
                                color: Colors.red,
                              ) : Icon(
                                Icons.check,
                                size: 26,
                                color: Colors.green,
                              )) : Icon(
                                Icons.check,
                                color: Colors.transparent,
                              ),
                            ],
                          )
                        ),
                        FormError(errors: passwordErrors),
                        SizedBox(height: size.height * 0.01),
                        Row(
                          children: [
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
                                });
                              },
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                //final isAuthenticated = await LocalAuthApi.fingerAuthenticate();
                                if(isoffline == false) {
                                  showDialogError(
                                    context,
                                    "Error",
                                    "This function is not currently supported by us. It will be updated soon",
                                    "Okay",
                                    widget.isDarkMode,
                                    "assets/images/8750-alert.json",
                                    18,
                                    () {
                                      Navigator.of(context).pop();
                                    }
                                  );
                                  // setState(() {
                                  //   if(userRef != null) {
                                  //     if(isAuthenticated) {
                                  //       userRef.child(FirebaseAuth.instance.currentUser.uid).once().then((DataSnapshot snap) {
                                  //         if(snap != null) {
                                  //           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
                                  //             urlImage: snap.value['urlImage'].toString(),
                                  //             nameTextAppBar: snap.value['name'].toString(),
                                  //             emailGoogleLogin: snap.value['email'].toString(),
                                  //             showBottomBar: snap.value['enroll'].toString(),
                                  //           )), (Route<dynamic> route) => false);
                                  //           displayToastMessage(context, AppLocalizations.of(context).loginByUserAccount);
                                  //         }
                                  //       });
                                  //     }
                                  //   } else {
                                  //     displayToastMessage(context, "Bạn cần tạo tài khoản");
                                  //   }
                                  // });
                                } else {
                                  displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
                                }
                              },
                              child: SvgPicture.asset(
                                "assets/icons/fingerprint.svg",
                                width: 40,
                                height: 40,
                                color: widget.isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(width: 30),
                            GestureDetector(
                              onTap: () async {
                                //final isAuthenticated = await LocalAuthApi.faceAuthenticate();
                                if(isoffline == false) {
                                  showDialogError(
                                    context,
                                    AppLocalizations.of(context).errorSupportTitle,
                                    AppLocalizations.of(context).errorSupportMsg,
                                    "Okay",
                                    widget.isDarkMode,
                                    "assets/images/8750-alert.json",
                                    18,
                                    () {
                                      Navigator.of(context).pop();
                                    }
                                  );
                                  // setState(() {
                                  //   if(userRef != null) {
                                  //     if(isAuthenticated) {
                                  //       userRef.child(FirebaseAuth.instance.currentUser.uid).once().then((DataSnapshot snap) {
                                  //         if(snap != null) {
                                  //           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
                                  //             urlImage: snap.value['urlImage'].toString(),
                                  //             nameTextAppBar: snap.value['name'].toString(),
                                  //             emailGoogleLogin: snap.value['email'].toString(),
                                  //             showBottomBar: snap.value['enroll'].toString(),
                                  //           )), (Route<dynamic> route) => false);
                                  //           displayToastMessage(context, AppLocalizations.of(context).loginByUserAccount);
                                  //         }
                                  //       });
                                  //     }
                                  //   } else {
                                  //     displayToastMessage(context, "Bạn cần tạo tài khoản");
                                  //   }
                                  // });
                                } else {
                                  displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
                                }
                              },
                              child: SvgPicture.asset(
                                "assets/icons/face_id_icon.svg",
                                width: 40,
                                height: 40,
                                color: widget.isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        RoundeButton(
                          text: AppLocalizations.of(context).login,
                          press: () {
                            if(isoffline == false) {
                              setState(() {
                                if(_formKey.currentState.validate()) {
                                  if(emailErrors.isEmpty && passwordErrors.isEmpty){
                                    loginAndAuthenticateUser(context, emailTextEditingController, passwordTextEditingController);
                                  }
                                }
                              });
                            } else {
                              displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
                            }
                          },
                          color: widget.isDarkMode ? Color(0xFF969696) : Colors.blue,
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialCard(
                              icon: "assets/icons/facebook.svg",
                              press: (){
                                if(isoffline == false) {
                                  setState(() {
                                    showDialogError(
                                      context,
                                      AppLocalizations.of(context).errorSupportTitle,
                                      AppLocalizations.of(context).errorSupportMsg,
                                      "Okay",
                                      widget.isDarkMode,
                                      "assets/images/8750-alert.json",
                                      18,
                                      () {
                                        Navigator.of(context).pop();
                                      }
                                    );
                                  });
                                  // setState(() {
                                  //   loginFacebook(
                                  //     context,
                                  //     loginStateSubscription,
                                  //     AppLocalizations.of(context).loginByFacebook
                                  //   );
                                  // });
                                } else {
                                  displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
                                }
                              },
                            ),
                            SocialCard(
                              icon: "assets/icons/github-logo.svg",
                              press: () {
                                if(isoffline == false) {
                                  setState(() {
                                    showDialogError(
                                      context,
                                      AppLocalizations.of(context).errorSupportTitle,
                                      AppLocalizations.of(context).errorSupportMsg,
                                      "Okay",
                                      widget.isDarkMode,
                                      "assets/images/8750-alert.json",
                                      18,
                                      () {
                                        Navigator.of(context).pop();
                                      }
                                    );
                                  });
                                } else {
                                  displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
                                }
                              },
                            ),
                            SocialCard(
                              icon: "assets/icons/google-icon.svg",
                              press: (){
                                if(isoffline == false) {
                                  setState(() {
                                    showDialogError(
                                      context,
                                      AppLocalizations.of(context).errorSupportTitle,
                                      AppLocalizations.of(context).errorSupportMsg,
                                      "Okay",
                                      widget.isDarkMode,
                                      "assets/images/8750-alert.json",
                                      18,
                                      () {
                                        Navigator.of(context).pop();
                                      }
                                    );
                                  });
                                  // setState(() {
                                  //   loginGoogle(
                                  //     context,
                                  //     loginStateSubscription,
                                  //     AppLocalizations.of(context).loginByGoogle
                                  //   );
                                  // });
                                } else {
                                  displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        AlreadyHaveAnAccountCheck(
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return CheckError();
      }
    );
  }
  
  void onToggleShowPass(){
    setState(() {
      _activeShowPass = !_activeShowPass;
    });
  }
}