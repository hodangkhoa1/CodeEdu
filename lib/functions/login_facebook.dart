import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/AllWidgets/display_toast_message.dart';
import 'package:code_edu/Screens/home/home_screen.dart';
import 'package:code_edu/blocs/auth_bloc_facebook.dart';
import 'package:code_edu/data/facebookAccount.dart';
import 'package:code_edu/requestAPI/databaseFacebook.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void loginFacebook(BuildContext context, StreamSubscription<User> loginStateSubscription, String successfulMsg) {
  OurFacebook _ourFacebook = OurFacebook();

  var authBlocFacebook = Provider.of<AuthBlocFacebook>(context,listen: false);
  authBlocFacebook.loginFacebook();
  loginStateSubscription = authBlocFacebook.currentUser.listen((facebookUser) async { 
    if (facebookUser != null){
      _ourFacebook.uid = facebookUser.uid;
      _ourFacebook.email = facebookUser.email;
      _ourFacebook.fullName = facebookUser.displayName;
      _ourFacebook.phoneNumber = facebookUser.phoneNumber;
      _ourFacebook.urlImage = facebookUser.photoURL;
      _ourFacebook.enroll = false;
      DatabaseFacebook().createAccountFacebook(_ourFacebook);
      QuerySnapshot snapshotFacebook = await FirebaseFirestore.instance.collection('facebookAccounts').get();
      snapshotFacebook.docs.forEach((snapValueFacebook) {
        if(snapValueFacebook != null) {
          OurFacebookDetail ourFacebookDetail = OurFacebookDetail.fromMap(snapValueFacebook.data());
          if(ourFacebookDetail.uid == facebookUser.uid) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
              urlImage: facebookUser.photoURL,
              nameTextAppBar: facebookUser.displayName,
              emailGoogleLogin: facebookUser.email,
              showBottomBar: ourFacebookDetail.enroll,
              uid: facebookUser.uid,
            )), (Route<dynamic> route) => false);
            displayToastMessage(context, successfulMsg);
          }
        }
      });
    }
  });
  }