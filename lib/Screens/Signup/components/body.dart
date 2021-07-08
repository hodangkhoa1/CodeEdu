import 'package:code_edu/Screens/Login/components/body.dart';
import 'package:code_edu/Screens/Login/login_screen.dart';
import 'package:code_edu/Screens/Signup/components/background.dart';
import 'package:code_edu/Screens/Signup/components/or_divider.dart';
import 'package:code_edu/Screens/complete_sign_up/complete_sign_up_screen.dart';
import 'package:code_edu/blocs/auth_bloc.dart';
import 'package:code_edu/blocs/auth_bloc_google.dart';
import 'package:code_edu/components/already_have_an_account_check.dart';
import 'package:code_edu/components/rounded_button.dart';
import 'package:code_edu/components/social_card.dart';
import 'package:code_edu/components/text_field_container.dart';
import 'package:code_edu/validators/reg_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  Body({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  AuthBloc authBloc = new AuthBloc();
  String email;
  String password;
  String confirmPassword;
  bool _activeShowPass = false;
  bool _activeShowConfirmPass = false;
  final List<String> emailErrors = [];
  final List<String> passwordErrors = [];
  final List<String> confirmPasswordErrors = [];

  @override
  Widget build(BuildContext context) {
    //final authGoogleBloc = Provider.of<AuthGoogleBloc>(context);
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
                  SizedBox(height: size.height * 0.07),
                  Text(
                    "SIGN UP",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/signup.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.02),
                  buildEmailFormField(),
                  FormError(errors: emailErrors),
                  buildPasswordFormField(),
                  FormError(errors: passwordErrors),
                  buildConfirmPasswordFormField(),
                  FormError(errors: confirmPasswordErrors),
                  RoundeButton(
                    text: "Continue",
                    press: onSignInClicked,
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                  OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialCard(
                        icon: "assets/icons/facebook.svg",
                        press: () {},
                      ),
                      SocialCard(
                        icon: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                      SocialCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {}//=> authGoogleBloc.loginGoogle(),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFieldContainer buildConfirmPasswordFormField() {
    return TextFieldContainer(
      color: confirmPasswordErrors.contains(matchPasswordError) ? Colors.red : Colors.blue,
      child: TextFormField(
        obscureText: !_activeShowConfirmPass,
        onSaved: (newValue) => confirmPassword = newValue,
        onChanged: (value) {
          if(Validations.isConfirmPassword(password, value) && confirmPasswordErrors.contains(matchPasswordError)) {
            setState(() {
              confirmPasswordErrors.remove(matchPasswordError);
            });
          }
        },
        validator: (value) {
          if(!Validations.isConfirmPassword(password, value) && !confirmPasswordErrors.contains(matchPasswordError)){
            setState(() {
              confirmPasswordErrors.add(matchPasswordError);
            });
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Confirm Password",
          icon: Icon(
            Icons.lock,
            color: confirmPasswordErrors.contains(matchPasswordError) ? Colors.red : Colors.blue,
          ),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: onToggleShowConfirmPass,
            child: Icon(
              _activeShowConfirmPass ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  TextFieldContainer buildPasswordFormField() {
    return TextFieldContainer(
      color: passwordErrors.contains(shortPasswordError) ? Colors.red : Colors.blue,
      child: TextFormField(
        obscureText: !_activeShowPass,
        onChanged: (value) {
          if(Validations.isStrongPassword(value) && passwordErrors.contains(shortPasswordError)){
            setState(() {
              passwordErrors.remove(shortPasswordError);
            });
          }
          password = value;
          return null;
        },
        validator: (value) {
          if(!Validations.isStrongPassword(value) && !passwordErrors.contains(shortPasswordError)){
            setState(() {
              passwordErrors.add(shortPasswordError);
            });
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Your Password",
          icon: Icon(
            Icons.lock,
            color: passwordErrors.contains(shortPasswordError) ? Colors.red : Colors.blue,
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
      color: emailErrors.contains(invalidEmailError) ? Colors.red : Colors.blue,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue,
        onChanged: (value) {
          if(emailValidatorRegExp.hasMatch(value) && emailErrors.contains(invalidEmailError)){
            setState(() {
              emailErrors.remove(invalidEmailError);
            });
          }
          email = value;
          return null;
        },
        validator: (value) {
          if(!emailValidatorRegExp.hasMatch(value) && !emailErrors.contains(invalidEmailError)){
            setState(() {
              emailErrors.add(invalidEmailError);
            });
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: "Your Email",
            icon: Icon(
              Icons.email_outlined,
              color: emailErrors.contains(invalidEmailError) ? Colors.red : Colors.blue,
            ),
            border: InputBorder.none),
      ),
    );
  }

  void onSignInClicked(){
    if(_formKey.currentState.validate()){
      if(emailErrors.isEmpty && passwordErrors.isEmpty && confirmPasswordErrors.isEmpty){
        authBloc.signUp(email, password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteSignUpScreen()));
      }
    }
  }

  void onToggleShowPass() {
    setState(() {
      _activeShowPass = !_activeShowPass;
    });
  }

  void onToggleShowConfirmPass() {
    setState(() {
      _activeShowConfirmPass = !_activeShowConfirmPass;
    });
  }
}