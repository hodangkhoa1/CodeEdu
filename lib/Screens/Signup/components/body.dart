import 'dart:async';

import 'package:code_edu/Screens/Login/login_screen.dart';
import 'package:code_edu/Screens/Signup/components/background.dart';
import 'package:code_edu/Screens/Signup/components/or_divider.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/Screens/sign_up_success/sign_up_success_screen.dart';
import 'package:code_edu/components/already_have_an_account_check.dart';
import 'package:code_edu/components/build_form_field_custom.dart';
import 'package:code_edu/components/display_toast_message.dart';
import 'package:code_edu/components/form_error.dart';
import 'package:code_edu/components/progressDialog.dart';
import 'package:code_edu/components/rounded_button.dart';
import 'package:code_edu/components/show_dialog_error.dart';
import 'package:code_edu/components/social_card.dart';
import 'package:code_edu/data/user.dart';
import 'package:code_edu/functions/login_facebook.dart';
import 'package:code_edu/functions/login_google.dart';
import 'package:code_edu/requestAPI/databaseUser.dart';
import 'package:code_edu/validators/reg_validator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class Body extends StatefulWidget {
  Body({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<Body> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String confirmPassword;
  String nameUser;
  String phoneNumber;
  bool _activeShowPass = false;
  bool _activeShowConfirmPass = false;
  final List<String> emailErrors = [];
  final List<String> passwordErrors = [];
  final List<String> confirmPasswordErrors = [];
  final List<String> nameUserErrors = [];
  final List<String> phoneNumberErrors = [];
  TextEditingController nameUserTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
  AnimationController _signupController;
  bool isoffline = false;
  StreamSubscription<User> loginStateSubscription;
  StreamSubscription internetconnection;
  FocusNode nameUserFieldFocusNode;
  FocusNode emailFieldFocusNode;
  FocusNode phoneNumberFieldFocusNode;
  FocusNode passwordFieldFocusNode;
  FocusNode confirmPasswordFieldFocusNode;

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
    _signupController = AnimationController(
      vsync: this,
    );
    super.initState();
    nameUserFieldFocusNode = FocusNode();
    nameUserFieldFocusNode.addListener(() {
      if(nameUserTextEditingController.text.trim().isEmpty && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(nameUserNullError) : nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername)) && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(shortUserNameError) : nameUserErrors.contains(AppLocalizations.of(context).shortUsername))){
        setState(() {
          AppLocalizations.of(context).language == "English" ? nameUserErrors.add(nameUserNullError) : nameUserErrors.add(AppLocalizations.of(context).pleaseEnterYourUsername);
        });
      } else if(nameUserTextEditingController.text.trim().length.toInt() < 5 && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(shortUserNameError) : nameUserErrors.contains(AppLocalizations.of(context).shortUsername)) && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(nameUserNullError) : nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername))) {
        setState(() {
          AppLocalizations.of(context).language == "English" ? nameUserErrors.add(shortUserNameError) : nameUserErrors.add(AppLocalizations.of(context).shortUsername);
        });
      }
    });
    emailFieldFocusNode = FocusNode();
    emailFieldFocusNode.addListener(() {
      if(emailTextEditingController.text.trim().isEmpty && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail)) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(invalidEmailError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail))) {
        setState(() {
          AppLocalizations.of(context).language == "English" ? emailErrors.add(emailNullError) : emailErrors.add(AppLocalizations.of(context).pleaseEnterYourEmail);
        });
      } else if(!emailValidatorRegExp.hasMatch(emailTextEditingController.text.trim()) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(invalidEmailError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail)) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail))){
        setState(() {
          AppLocalizations.of(context).language == "English" ? emailErrors.add(invalidEmailError) : emailErrors.add(AppLocalizations.of(context).pleaseEnterValidEmail);
        });
      }
    });
    phoneNumberFieldFocusNode = FocusNode();
    phoneNumberFieldFocusNode.addListener(() {
      if(phoneNumberTextEditingController.text.trim().isEmpty
          && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(phoneNumberNullError) : phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber))
          && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(shortPhoneNumberError) : phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber))
      ){
        setState(() {
          AppLocalizations.of(context).language == "English" ? phoneNumberErrors.add(phoneNumberNullError) : phoneNumberErrors.add(AppLocalizations.of(context).pleaseEnterYourPhoneNumber);
        });
      } else if(phoneNumberTextEditingController.text.trim().length.toInt() != 10
          && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(shortPhoneNumberError) : phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber))
          && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(phoneNumberNullError) : phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber))
      ) {
        setState(() {
          AppLocalizations.of(context).language == "English" ? phoneNumberErrors.add(shortPhoneNumberError) : phoneNumberErrors.add(AppLocalizations.of(context).shortPhoneNumber);
        });
      }
    });
    passwordFieldFocusNode = FocusNode();
    passwordFieldFocusNode.addListener(() {
      if(passwordTextEditingController.text.trim().isEmpty
          && !(AppLocalizations.of(context).language == "English" ? passwordErrors.contains(passwordNullError) : passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword))
          && !(AppLocalizations.of(context).language == "English" ? passwordErrors.contains(shortPasswordError) : passwordErrors.contains(AppLocalizations.of(context).passwordIsTooWeak))
      ) {
        setState(() {
          AppLocalizations.of(context).language == "English" ? passwordErrors.add(passwordNullError) : passwordErrors.add(AppLocalizations.of(context).pleaseEnterYourPassword);
        });
      } else if(!Validations.isStrongPassword(passwordTextEditingController.text.trim())
          && !(AppLocalizations.of(context).language == "English" ? passwordErrors.contains(shortPasswordError) : passwordErrors.contains(AppLocalizations.of(context).passwordIsTooWeak))
          && !(AppLocalizations.of(context).language == "English" ? passwordErrors.contains(passwordNullError) : passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword))
      ) {
        setState(() {
          AppLocalizations.of(context).language == "English" ? passwordErrors.add(shortPasswordError) : passwordErrors.add(AppLocalizations.of(context).passwordIsTooWeak);
        });
      }
    });
    confirmPasswordFieldFocusNode = FocusNode();
    confirmPasswordFieldFocusNode.addListener(() {
      if(confirmPasswordTextEditingController.text.trim().isEmpty && !(AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.contains(confirmPasswordError) : confirmPasswordErrors.contains(AppLocalizations.of(context).confirmPassword)) && !(AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.contains(matchPasswordError) : confirmPasswordErrors.contains(AppLocalizations.of(context).passwordDoesNotMatch))) {
        setState(() {
          AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.add(confirmPasswordError) : confirmPasswordErrors.add(AppLocalizations.of(context).confirmPassword);
        });
      } else if(!Validations.isConfirmPassword(password, confirmPasswordTextEditingController.text.trim())
          && !(AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.contains(matchPasswordError) : confirmPasswordErrors.contains(AppLocalizations.of(context).passwordDoesNotMatch))
          && !(AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.contains(confirmPasswordError) : confirmPasswordErrors.contains(AppLocalizations.of(context).confirmPassword))){
        setState(() {
          AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.add(matchPasswordError) : confirmPasswordErrors.add(AppLocalizations.of(context).passwordDoesNotMatch);
        });
      }
    });
  }

  @override
  void dispose() {
    internetconnection.cancel();
    _signupController.dispose();
    super.dispose();
    nameUserFieldFocusNode.addListener(() {
      super.dispose();
    });
    emailFieldFocusNode.addListener(() {
      super.dispose();
    });
    phoneNumberFieldFocusNode.addListener(() {
      super.dispose();
    });
    passwordFieldFocusNode.addListener(() {
      super.dispose();
    });
    confirmPasswordFieldFocusNode.addListener(() {
      super.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    AppLocalizations.of(context).signUp,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Lottie.asset(
                    "assets/images/38435-register.json",
                    height: size.height * 0.4,
                    controller: _signupController,
                    onLoaded: (animation) {
                      _signupController..duration = animation.duration..repeat(
                        reverse: true
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  buildFormFieldCustom(
                    nameUserErrors,
                    nameUserFieldFocusNode,
                    1,
                    1,
                    nameUserTextEditingController,
                    BorderRadius.circular(29),
                    (AppLocalizations.of(context).language == "English" ? (nameUserErrors.contains(nameUserNullError) || nameUserErrors.contains(shortUserNameError)) : (nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername) || nameUserErrors.contains(AppLocalizations.of(context).shortUsername))) ? Colors.red : Colors.green,
                    TextInputType.name,
                    false,
                    nameUser,
                    (value) {
                      if(value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(nameUserNullError) : nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername)) && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(shortUserNameError) : nameUserErrors.contains(AppLocalizations.of(context).shortUsername))){
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? nameUserErrors.remove(nameUserNullError) : nameUserErrors.remove(AppLocalizations.of(context).pleaseEnterYourUsername);
                        });
                      } else if(value.length.toInt() >= 5 && (AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(shortUserNameError) : nameUserErrors.contains(AppLocalizations.of(context).shortUsername)) && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(nameUserNullError) : nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername))) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? nameUserErrors.remove(shortUserNameError) : nameUserErrors.remove(AppLocalizations.of(context).shortUsername);
                        });
                      }
                      nameUser = value;
                      return null;
                    },
                    (value) {
                      if(value.isEmpty && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(nameUserNullError) : nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername)) && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(shortUserNameError) : nameUserErrors.contains(AppLocalizations.of(context).shortUsername))){
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? nameUserErrors.add(nameUserNullError) : nameUserErrors.add(AppLocalizations.of(context).pleaseEnterYourUsername);
                        });
                      } else if(value.length.toInt() < 5 && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(shortUserNameError) : nameUserErrors.contains(AppLocalizations.of(context).shortUsername)) && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(nameUserNullError) : nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername))) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? nameUserErrors.add(shortUserNameError) : nameUserErrors.add(AppLocalizations.of(context).shortUsername);
                        });
                      }
                      return null;
                    },
                    AppLocalizations.of(context).yourUserName,
                    FontAwesomeIcons.user,
                    (AppLocalizations.of(context).language == "English" ? (nameUserErrors.contains(nameUserNullError) || nameUserErrors.contains(shortUserNameError)) : (nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername) || nameUserErrors.contains(AppLocalizations.of(context).shortUsername))) ? Colors.red : Colors.green,
                    (nameUserTextEditingController.text.trim().isNotEmpty || nameUserErrors.isNotEmpty)
                      ? ((AppLocalizations.of(context).language == "English" ? (nameUserErrors.contains(nameUserNullError) || nameUserErrors.contains(shortUserNameError)) : (nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername) || nameUserErrors.contains(AppLocalizations.of(context).shortUsername))) ? Icon(
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
                  nameUserTextEditingController.text.isEmpty ? Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                      left: 25
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Tên người dùng phải lớn hơn 5 ký tự.",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey
                        ),
                      ),
                    ),
                  ) : FormError(errors: nameUserErrors),
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
                  emailTextEditingController.text.isEmpty ? Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                      left: 25
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Vd: abc@gmail.com",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey
                        ),
                      ),
                    ),
                  ) : FormError(errors: emailErrors),
                  buildFormFieldCustom(
                    phoneNumberErrors,
                    phoneNumberFieldFocusNode,
                    1,
                    1,
                    phoneNumberTextEditingController,
                    BorderRadius.circular(29),
                    (AppLocalizations.of(context).language == "English" ? (phoneNumberErrors.contains(phoneNumberNullError) || phoneNumberErrors.contains(shortPhoneNumberError)) : (phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber)) || phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber)) ? Colors.red : Colors.green,
                    TextInputType.phone,
                    false,
                    phoneNumber,
                    (value) {
                      if(value.isNotEmpty
                          && (AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(phoneNumberNullError) : phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber))
                          && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(shortPhoneNumberError) : phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber))
                      ) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? phoneNumberErrors.remove(phoneNumberNullError) : phoneNumberErrors.remove(AppLocalizations.of(context).pleaseEnterYourPhoneNumber);
                        });
                      } else if(value.length.toInt() == 10
                          && (AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(shortPhoneNumberError) : phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber))
                          && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(phoneNumberNullError) : phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber))
                      ) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? phoneNumberErrors.remove(shortPhoneNumberError) : phoneNumberErrors.remove(AppLocalizations.of(context).shortPhoneNumber);
                        });
                      }
                      phoneNumber = value;
                      return null;
                    },
                    (value) {
                      if(value.isEmpty
                          && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(phoneNumberNullError) : phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber))
                          && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(shortPhoneNumberError) : phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber))
                      ){
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? phoneNumberErrors.add(phoneNumberNullError) : phoneNumberErrors.add(AppLocalizations.of(context).pleaseEnterYourPhoneNumber);
                        });
                      } else if(value.length.toInt() != 10
                          && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(shortPhoneNumberError) : phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber))
                          && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(phoneNumberNullError) : phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber))
                      ) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? phoneNumberErrors.add(shortPhoneNumberError) : phoneNumberErrors.add(AppLocalizations.of(context).shortPhoneNumber);
                        });
                      }
                      return null;
                    },
                    AppLocalizations.of(context).yourPhoneNumber,
                    FontAwesomeIcons.mobileAlt,
                    (AppLocalizations.of(context).language == "English" ? (phoneNumberErrors.contains(phoneNumberNullError) || phoneNumberErrors.contains(shortPhoneNumberError)) : (phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber)) || phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber)) ? Colors.red : Colors.green,
                    (phoneNumberTextEditingController.text.trim().isNotEmpty || phoneNumberErrors.isNotEmpty)
                    ? ((AppLocalizations.of(context).language == "English" ? (phoneNumberErrors.contains(phoneNumberNullError) || phoneNumberErrors.contains(shortPhoneNumberError)) : (phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber) || phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber))) ? Icon(
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
                  phoneNumberTextEditingController.text.isEmpty ? Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                      left: 25
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Số điện thoại phải có 10 số.",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey
                        ),
                      ),
                    ),
                  ) : FormError(errors: phoneNumberErrors),
                  buildFormFieldCustom(
                    passwordErrors,
                    passwordFieldFocusNode,
                    1,
                    1,
                    passwordTextEditingController,
                    BorderRadius.circular(29),
                    (AppLocalizations.of(context).language == "English" ? (passwordErrors.contains(shortPasswordError) || passwordErrors.contains(passwordNullError)) : (passwordErrors.contains(AppLocalizations.of(context).passwordIsTooWeak)) || passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword)) ? Colors.red : Colors.green,
                    TextInputType.visiblePassword,
                    !_activeShowPass,
                    password,
                    (value) {
                      if(value.isNotEmpty
                          && (AppLocalizations.of(context).language == "English" ? passwordErrors.contains(passwordNullError) : passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword))
                          && !(AppLocalizations.of(context).language == "English" ? passwordErrors.contains(shortPasswordError) : passwordErrors.contains(AppLocalizations.of(context).passwordIsTooWeak))
                      ) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? passwordErrors.remove(passwordNullError) : passwordErrors.remove(AppLocalizations.of(context).pleaseEnterYourPassword);
                        });
                      } else if(Validations.isStrongPassword(value)
                          && (AppLocalizations.of(context).language == "English" ? passwordErrors.contains(shortPasswordError) : passwordErrors.contains(AppLocalizations.of(context).passwordIsTooWeak))
                          && !(AppLocalizations.of(context).language == "English" ? passwordErrors.contains(passwordNullError) : passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword))
                      ) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? passwordErrors.remove(shortPasswordError) : passwordErrors.remove(AppLocalizations.of(context).passwordIsTooWeak);
                        });
                      }
                      password = value;
                      return null;
                    },
                    (value) {
                      if(value.isEmpty
                          && !(AppLocalizations.of(context).language == "English" ? passwordErrors.contains(passwordNullError) : passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword))
                          && !(AppLocalizations.of(context).language == "English" ? passwordErrors.contains(shortPasswordError) : passwordErrors.contains(AppLocalizations.of(context).passwordIsTooWeak))
                      ) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? passwordErrors.add(passwordNullError) : passwordErrors.add(AppLocalizations.of(context).pleaseEnterYourPassword);
                        });
                      } else if(!Validations.isStrongPassword(value)
                          && !(AppLocalizations.of(context).language == "English" ? passwordErrors.contains(shortPasswordError) : passwordErrors.contains(AppLocalizations.of(context).passwordIsTooWeak))
                          && !(AppLocalizations.of(context).language == "English" ? passwordErrors.contains(passwordNullError) : passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword))
                      ) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? passwordErrors.add(shortPasswordError) : passwordErrors.add(AppLocalizations.of(context).passwordIsTooWeak);
                        });
                      }
                      return null;
                    },
                    AppLocalizations.of(context).yourPassword,
                    Icons.lock,
                    (AppLocalizations.of(context).language == "English" ? (passwordErrors.contains(shortPasswordError) || passwordErrors.contains(passwordNullError)) : (passwordErrors.contains(AppLocalizations.of(context).passwordIsTooWeak)) || passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword)) ? Colors.red : Colors.green,
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
                        ? ((AppLocalizations.of(context).language == "English" ? (passwordErrors.contains(shortPasswordError) || passwordErrors.contains(passwordNullError)) : (passwordErrors.contains(AppLocalizations.of(context).passwordIsTooWeak) || passwordErrors.contains(AppLocalizations.of(context).pleaseEnterYourPassword))) ? Icon(
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
                  passwordTextEditingController.text.isEmpty ? Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 8
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context).passwordIsTooFair,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey
                        ),
                      ),
                    ),
                  ) : FormError(errors: passwordErrors),
                  buildFormFieldCustom(
                    confirmPasswordErrors,
                    confirmPasswordFieldFocusNode,
                    1,
                    1,
                    confirmPasswordTextEditingController,
                    BorderRadius.circular(29),
                    (AppLocalizations.of(context).language == "English" ? (confirmPasswordErrors.contains(matchPasswordError) || confirmPasswordErrors.contains(confirmPasswordError)) : (confirmPasswordErrors.contains(AppLocalizations.of(context).passwordDoesNotMatch)) || confirmPasswordErrors.contains(AppLocalizations.of(context).confirmPassword)) ? Colors.red : Colors.green,
                    TextInputType.visiblePassword,
                    !_activeShowConfirmPass,
                    confirmPassword,
                    (value) {
                      if(value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.contains(confirmPasswordError) : confirmPasswordErrors.contains(AppLocalizations.of(context).confirmPassword)) && !(AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.contains(matchPasswordError) : confirmPasswordErrors.contains(AppLocalizations.of(context).passwordDoesNotMatch))) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.remove(confirmPasswordError) : confirmPasswordErrors.remove(AppLocalizations.of(context).confirmPassword);
                        });
                      } else if(Validations.isConfirmPassword(password, value) && (AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.contains(matchPasswordError) : confirmPasswordErrors.contains(AppLocalizations.of(context).passwordDoesNotMatch)) && !(AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.contains(confirmPasswordError) : confirmPasswordErrors.contains(AppLocalizations.of(context).confirmPassword))) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.remove(matchPasswordError) : confirmPasswordErrors.remove(AppLocalizations.of(context).passwordDoesNotMatch);
                        });
                      }
                    },
                    (value) {
                      if(value.isEmpty && !(AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.contains(confirmPasswordError) : confirmPasswordErrors.contains(AppLocalizations.of(context).confirmPassword)) && !(AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.contains(matchPasswordError) : confirmPasswordErrors.contains(AppLocalizations.of(context).passwordDoesNotMatch))) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.add(confirmPasswordError) : confirmPasswordErrors.add(AppLocalizations.of(context).confirmPassword);
                        });
                      } else if(!Validations.isConfirmPassword(password, value)
                          && !(AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.contains(matchPasswordError) : confirmPasswordErrors.contains(AppLocalizations.of(context).passwordDoesNotMatch))
                          && !(AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.contains(confirmPasswordError) : confirmPasswordErrors.contains(AppLocalizations.of(context).confirmPassword))){
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? confirmPasswordErrors.add(matchPasswordError) : confirmPasswordErrors.add(AppLocalizations.of(context).passwordDoesNotMatch);
                        });
                      }
                      return null;
                    },
                    AppLocalizations.of(context).confirmPassword,
                    Icons.lock,
                    (AppLocalizations.of(context).language == "English" ? (confirmPasswordErrors.contains(matchPasswordError) || confirmPasswordErrors.contains(confirmPasswordError)) : (confirmPasswordErrors.contains(AppLocalizations.of(context).passwordDoesNotMatch) || confirmPasswordErrors.contains(AppLocalizations.of(context).confirmPassword))) ? Colors.red : Colors.green,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: onToggleShowConfirmPass,
                          child: Icon(
                            _activeShowConfirmPass ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 6),
                        (confirmPasswordTextEditingController.text.trim().isNotEmpty || confirmPasswordErrors.isNotEmpty)
                        ? ((AppLocalizations.of(context).language == "English" ? (confirmPasswordErrors.contains(matchPasswordError) || confirmPasswordErrors.contains(confirmPasswordError)) : (confirmPasswordErrors.contains(AppLocalizations.of(context).passwordDoesNotMatch) || confirmPasswordErrors.contains(AppLocalizations.of(context).confirmPassword))) ? Icon(
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
                  FormError(errors: confirmPasswordErrors),
                  RoundeButton(
                    text: AppLocalizations.of(context).createAccount,
                    press: (){
                      if(isoffline == false) {
                        setState(() {
                          if(_formKey.currentState.validate()){
                            if(emailErrors.isEmpty && passwordErrors.isEmpty && confirmPasswordErrors.isEmpty && nameUserErrors.isEmpty && phoneNumberErrors.isEmpty){
                              registerNewUser(context);
                            }
                          }
                        });
                      } else {
                        displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
                      }
                    },
                    color: isDarkMode ? Color(0xFF969696) : Colors.blue,
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      if(isoffline == false) {
                        setState(() {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginScreen(
                            isDarkMode: isDarkMode,
                          )), (route) => false);
                        });
                      } else {
                        displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
                      }
                    },
                  ),
                  OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialCard(
                        icon: "assets/icons/facebook.svg",
                        press: () {
                          if(isoffline == false) {
                            setState(() {
                              showDialogError(
                                context,
                                AppLocalizations.of(context).errorSupportTitle,
                                AppLocalizations.of(context).errorSupportMsg,
                                "Okay",
                                isDarkMode,
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
                                isDarkMode,
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
                        press: () {
                          if(isoffline == false) {
                            setState(() {
                              showDialogError(
                                context,
                                AppLocalizations.of(context).errorSupportTitle,
                                AppLocalizations.of(context).errorSupportMsg,
                                "Okay",
                                isDarkMode,
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
                        }
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

  void registerNewUser(BuildContext context) async {
    OurUser _user = OurUser();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog(
          message: AppLocalizations.of(context).registeringAccount,
        );
      }
    );

    try {
      final User firebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      ).catchError((errMsg){
        Navigator.pop(context);
        displayToastMessage(context, "Error: " + errMsg.toString());
      })).user;

      if(firebaseUser != null) {
        _user.uid = firebaseUser.uid;
        _user.email = emailTextEditingController.text.trim();
        _user.fullName = nameUserTextEditingController.text.trim();
        _user.phoneNumber = phoneNumberTextEditingController.text.trim();
        _user.urlImage = "https://firebasestorage.googleapis.com/v0/b/codeeduapp.appspot.com/o/21-avatar-outline.gif?alt=media&token=7b98a6a0-15c8-4fd0-9d78-2ed2d468112a";
        _user.nameUniversity = "";
        _user.enroll = false;
        OurDatabase().createUser(_user);
        sendVerificationEmail();
        displayToastMessage(context, AppLocalizations.of(context).congratulationsCreated);
      } else {
        Navigator.pop(context);
        displayToastMessage(context, AppLocalizations.of(context).newUserAccountCreatedError);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void sendVerificationEmail() async {
    User firebaseUser = await FirebaseAuth.instance.currentUser;
    await firebaseUser.sendEmailVerification();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => SignUpSuccessScreen()), (route) => false);
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