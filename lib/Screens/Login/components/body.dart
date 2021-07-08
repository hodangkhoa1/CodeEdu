import 'dart:async';
import 'dart:convert';

import 'package:code_edu/Screens/Login/components/background.dart';
import 'package:code_edu/Screens/Signup/signup_screen.dart';
import 'package:code_edu/Screens/forgot_password/forgot_password_screen.dart';
import 'package:code_edu/Screens/home/home_screen.dart';
import 'package:code_edu/Screens/sign_up_success/sign_up_success_screen.dart';
import 'package:code_edu/blocs/auth_bloc_google.dart';
import 'package:code_edu/components/already_have_an_account_check.dart';
import 'package:code_edu/components/rounded_button.dart';
import 'package:code_edu/components/social_card.dart';
import 'package:code_edu/components/text_field_container.dart';
import 'package:code_edu/requestAPI/local_auth_api.dart';
import 'package:code_edu/validators/reg_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  Body({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<Body> {
  StreamSubscription<FirebaseAuth> loginStateSubscription;
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool _activeShowPass = false;
  final List<String> emailErrors = [];
  final List<String> passwordErrors = [];
  bool remember = false;

  @override
  void initState(){
    var authBloc = Provider.of<AuthGoogleBloc>(context, listen: false);
    authBloc.currentUser.listen((firebaseUser) {
      if(firebaseUser != null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authGoogleBloc = Provider.of<AuthGoogleBloc>(context);
    Size size = MediaQuery.of(context).size;
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
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blue),
                  ),
                  SizedBox(height: size.height * 0.02),
                  SvgPicture.asset(
                    "assets/icons/login-code.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.02),
                  buildEmailFormField(),
                  FormError(errors: emailErrors),
                  buildPasswordFormField(),
                  FormError(errors: passwordErrors),
                  Row(
                    children: [
                      Checkbox(
                          value: remember,
                          onChanged: (value) {
                            setState(() {
                              remember = value;
                            });
                          }),
                      Text("Remember me"),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgotPasswordScreen()));
                        },
                        child: Text(
                          "Forgot Password",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: deprecated_member_use
                      GestureDetector(
                        onTap: () async {
                          final isAuthenticated = await LocalAuthApi.fingerAuthenticate();
                          if(isAuthenticated) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          }
                        },
                        child: SvgPicture.asset(
                          "assets/icons/fingerprint.svg",
                          width: 40,
                          height: 40,
                        ),
                      ),
                      SizedBox(width: 30),
                      GestureDetector(
                        onTap: () async {
                          final isAuthenticated = await LocalAuthApi.faceAuthenticate();
                          if(isAuthenticated) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          }
                        },
                        child: SvgPicture.asset(
                          "assets/icons/face-detection.svg",
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: size.height * 0.01),
                  // FormError(errors: errors),
                  SizedBox(height: size.height * 0.01),
                  RoundeButton(
                    text: "LOGIN",
                    press: onSignInClicked,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialCard(
                        icon: "assets/icons/facebook.svg",
                        press: () {},
                            // => authBloc.loginFacebook(),
                          // loginFacebook().whenComplete(() => {
                          //   print("thành công")
                          // });
                      ),
                      SocialCard(
                        icon: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                      SocialCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () => authGoogleBloc.loginGoogle(),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ),
                      );
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

  TextFieldContainer buildPasswordFormField() {
    return TextFieldContainer(
      color: passwordErrors.contains(passwordNullError) ? Colors.red : Colors.blue,
      child: TextFormField(
        obscureText: !_activeShowPass,
        onSaved: (newValue) => password = newValue,
        onChanged: (value) {
          if(value.isNotEmpty && passwordErrors.contains(passwordNullError)){
            setState(() {
              passwordErrors.remove(passwordNullError);
            });
          }
          return null;
        },
        validator: (value) {
          if(value.isEmpty && !passwordErrors.contains(passwordNullError)){
            setState(() {
              passwordErrors.add(passwordNullError);
            });
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Your Password",
          icon: Icon(
            Icons.lock,
            color: passwordErrors.contains(passwordNullError) ? Colors.red : Colors.blue,
          ),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: onToggleShowPass,
            child: Icon(
              _activeShowPass ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  TextFieldContainer buildEmailFormField() {
    return TextFieldContainer(
      color: emailErrors.contains(emailNullError) ? Colors.red : Colors.blue,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue,
        onChanged: (value) {
          if (value.isNotEmpty && emailErrors.contains(emailNullError)) {
            setState(() {
              emailErrors.remove(emailNullError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty && !emailErrors.contains(emailNullError)) {
            setState(() {
              emailErrors.add(emailNullError);
            });
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Your Email",
          icon: Icon(
            Icons.email_outlined,
            color: emailErrors.contains(emailNullError) ? Colors.red : Colors.blue,
          ),
          border: InputBorder.none
        ),
      ),
    );
  }

  void onSignInClicked() {
    setState(() {
      if(_formKey.currentState.validate()){
        if(emailErrors.isEmpty && passwordErrors.isEmpty){
          
        }
      }
    });
  }

  void onToggleShowPass(){
    setState(() {
      _activeShowPass = !_activeShowPass;
    });
  }
}

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: List.generate(errors.length, (index) => formErrorText(error: errors[index])),
      ),
    );
  }

  Row formErrorText({String error}) {
    return Row(
        children: [
          SvgPicture.asset(
            "assets/icons/error.svg",
            height: 16,
            width: 16,
          ),
          SizedBox(
            width: 10,
          ),
          Text(error),
        ],
      );
  }
}