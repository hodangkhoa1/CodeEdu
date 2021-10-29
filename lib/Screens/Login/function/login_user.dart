import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/Screens/home/home_screen.dart';
import 'package:code_edu/components/display_toast_message.dart';
import 'package:code_edu/components/progressDialog.dart';
import 'package:code_edu/data/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void loginAndAuthenticateUser(BuildContext context, TextEditingController emailTextEditingController, TextEditingController passwordTextEditingController) async {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog(
          message: AppLocalizations.of(context).authenticating,
        );
      }
    );

    try {
      final User firebaseUsers = (await _firebaseAuth.signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      ).catchError((errMsg){
        Navigator.pop(context);
        displayToastMessage(context, AppLocalizations.of(context).noRecordAccountMessage);
      })).user;
      if(firebaseUsers.emailVerified == true) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
        snapshot.docs.forEach((snapValue) {
          if(snapValue != null) {
            OurUserDetail ourUserDetail = OurUserDetail.fromMap(snapValue.data());
            if(ourUserDetail.uid == firebaseUsers.uid) {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
                urlImage: ourUserDetail.urlImage,
                nameUser: ourUserDetail.fullName,
                emailUser: ourUserDetail.email,
                nameUniversity: ourUserDetail.nameUniversity,
                phoneNumber: ourUserDetail.phoneNumber,
                showBottomBar: ourUserDetail.enroll,
                uid: ourUserDetail.uid,
                dateOfBirth: ourUserDetail.dateOfBirth.toDate(),
              )), (Route<dynamic> route) => false);
              displayToastMessage(context, AppLocalizations.of(context).loginByUserAccount);
            }
          } else {
            Navigator.pop(context);
            _firebaseAuth.signOut();
            displayToastMessage(context, AppLocalizations.of(context).noRecordAccountMessage);
          }
        });
      } else {
        Navigator.pop(context);
        displayToastMessage(context, AppLocalizations.of(context).errorSignedin);
      }
    } catch (e) {
      print(e.toString());
    }
  }