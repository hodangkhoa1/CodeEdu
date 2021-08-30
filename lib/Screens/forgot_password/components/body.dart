import 'package:code_edu/Screens/Signup/signup_screen.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/components/already_have_an_account_check.dart';
import 'package:code_edu/components/form_error.dart';
import 'package:code_edu/components/rounded_button.dart';
import 'package:code_edu/validators/reg_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  String email;
  final List<String> emailErrors = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    
    return Form(
      key: _formKey,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.05),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.blue,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  "Please enter your email and we will send \nyou a link to return to your account",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.2),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) => email = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty && emailErrors.contains(emailNullError)) {
                      setState(() {
                        emailErrors.remove(emailNullError);
                      });
                    } else if (emailValidatorRegExp.hasMatch(value) && emailErrors.contains(invalidEmailError)) {
                      setState(() {
                        emailErrors.remove(invalidEmailError);
                      });
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty && !emailErrors.contains(emailNullError)) {
                      setState(() {
                        emailErrors.add(emailNullError);
                      });
                    } else if (!emailValidatorRegExp.hasMatch(value) && !emailErrors.contains(invalidEmailError)) {
                      setState(() {
                        emailErrors.add(invalidEmailError);
                      });
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(color: emailErrors.isNotEmpty ? Colors.red : Color(0xFF8B8B8B)),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(color: Colors.blue),
                        gapPadding: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(color: Colors.blue),
                        gapPadding: 10),
                    suffixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                      child: SvgPicture.asset(
                        "assets/icons/Mail.svg",
                        height: 18,
                        color: emailErrors.isNotEmpty ? Colors.red : Color(0xFF8B8B8B),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                FormError(errors: emailErrors),
                SizedBox(height: size.height * 0.02),
                RoundeButton(
                  text: "Continue",
                  press: onSignInClicked,
                  color: isDarkMode ? Color(0xFF969696) : Colors.blue,
                ),
                SizedBox(height: size.height * 0.22),
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
    );
  }

  void onSignInClicked() {
    setState(() {
      if(_formKey.currentState.validate()){
        if(emailErrors.isEmpty){
          
        }
      }
    });
  }
}
