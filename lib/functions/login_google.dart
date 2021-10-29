import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/Screens/home/home_screen.dart';
import 'package:code_edu/blocs/auth_bloc_google.dart';
import 'package:code_edu/components/display_toast_message.dart';
import 'package:code_edu/data/googleAccount.dart';
import 'package:code_edu/requestAPI/databaseGoogle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void loginGoogle(BuildContext context, StreamSubscription<User> loginStateSubscription, String successfulMsg) {
  OurGoogle _ourGoogle = OurGoogle();

  var authBlocGoogle = Provider.of<AuthGoogleBloc>(context, listen: false);
  authBlocGoogle.loginGoogle();
  loginStateSubscription = authBlocGoogle.currentUser.listen((googleUser) async {
    if (googleUser != null) {
      _ourGoogle.uid = googleUser.uid;
      _ourGoogle.email = googleUser.email;
      _ourGoogle.fullName = googleUser.displayName;
      _ourGoogle.phoneNumber = googleUser.phoneNumber;
      _ourGoogle.urlImage = googleUser.photoURL;
      _ourGoogle.nameUniversity = "";
      _ourGoogle.enroll = false;
      DatabaseGoogle().createAccountGoogle(_ourGoogle);
      QuerySnapshot snapshotGoogle = await FirebaseFirestore.instance.collection('googleAccounts').get();
      snapshotGoogle.docs.forEach((snapValueGoogle) {
        if(snapValueGoogle != null) {
          OurGoogleDetail ourGoogleDetail = OurGoogleDetail.fromMap(snapValueGoogle.data());
          if(ourGoogleDetail.uid == googleUser.uid) {
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
            displayToastMessage(context, successfulMsg);
          }
        }
      });
    }
  });
}