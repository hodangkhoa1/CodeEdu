import 'package:code_edu/AllWidgets/display_toast_message.dart';
import 'package:code_edu/AllWidgets/progressDialog.dart';
import 'package:code_edu/Screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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

      if(firebaseUsers.emailVerified != null) {
        FirebaseDatabase.instance.reference().child(firebaseUsers.uid).once().then((DataSnapshot snap) {
          if(snap.value != null) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
              urlImage: snap.value['urlImage'].toString(),
              nameTextAppBar: snap.value['name'].toString(),
              emailGoogleLogin: snap.value['email'].toString(),
            )), (Route<dynamic> route) => false);
            displayToastMessage(context, AppLocalizations.of(context).loginByUserAccount);
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