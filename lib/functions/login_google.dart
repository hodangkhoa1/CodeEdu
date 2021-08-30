import 'dart:async';

import 'package:code_edu/AllWidgets/display_toast_message.dart';
import 'package:code_edu/Screens/home/home_screen.dart';
import 'package:code_edu/blocs/auth_bloc_google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void loginGoogle(BuildContext context, StreamSubscription<User> loginStateSubscription) {
    var authBlocGoogle = Provider.of<AuthGoogleBloc>(context, listen: false);
    authBlocGoogle.loginGoogle();
    loginStateSubscription = authBlocGoogle.currentUser.listen((googleUser) {
      if (googleUser != null) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
          urlImage: googleUser.photoURL,
          nameTextAppBar: googleUser.displayName,
          emailGoogleLogin: googleUser.email,
        )), (Route<dynamic> route) => false);
        displayToastMessage(context, "Bạn đăng nhập bằng google");
      }
    });
  }