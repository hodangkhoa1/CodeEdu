import 'dart:async';

import 'package:code_edu/AllWidgets/display_toast_message.dart';
import 'package:code_edu/Screens/home/home_screen.dart';
import 'package:code_edu/blocs/auth_bloc_facebook.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void loginFacebook(BuildContext context, StreamSubscription<User> loginStateSubscription) {
    var authBlocFacebook = Provider.of<AuthBlocFacebook>(context,listen: false);
    authBlocFacebook.loginFacebook();
    loginStateSubscription = authBlocFacebook.currentUser.listen((facebookUser) { 
      if (facebookUser != null){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
          urlImage: facebookUser.photoURL,
          nameTextAppBar: facebookUser.displayName,
          emailGoogleLogin: facebookUser.email,
        )), (Route<dynamic> route) => false);
        displayToastMessage(context, "Bạn đăng nhập bằng facebook");
      }
    });
  }