import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/components/display_toast_message.dart';
import 'package:code_edu/components/show_dialog_error.dart';
import 'package:code_edu/data/facebookAccount.dart';
import 'package:code_edu/data/googleAccount.dart';
import 'package:code_edu/data/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> enrollFunction(BuildContext context, bool isDarkMode, bool checkEnroll,
    bool isoffline, String successfully, String congratulationsRegistrationCourse,
    String error, String errorRegistrationCourse, String pleaseConnectToTheInternet) async {
  User user = FirebaseAuth.instance.currentUser;

  if(isoffline == false) {
    if(user != null) {
      QuerySnapshot snapshotUser = await FirebaseFirestore.instance.collection('users').get();
      QuerySnapshot snapshotGoogle = await FirebaseFirestore.instance.collection('googleAccounts').get();
      QuerySnapshot snapshotFacebook = await FirebaseFirestore.instance.collection('facebookAccounts').get();
      snapshotUser.docs.forEach((snapValueUser) {
        if(snapValueUser != null) {
          OurUserDetail ourUserDetail = OurUserDetail.fromMap(snapValueUser.data());
          if(ourUserDetail.uid == user.uid) {
            FirebaseFirestore.instance.collection('users').doc(ourUserDetail.uid).update({
              'enroll': true
            }).whenComplete(() {
              checkEnroll = !checkEnroll;
              showDialogError(
                context,
                successfully,
                congratulationsRegistrationCourse,
                "Okay",
                isDarkMode,
                "assets/images/10470-confirm.json",
                18,
                () {
                  Navigator.of(context).pop();
                }
              );
            });
          } else {
            snapshotGoogle.docs.forEach((snapValueGoogle) {
              if(snapValueGoogle != null) {
                OurGoogleDetail ourGoogleDetail = OurGoogleDetail.fromMap(snapValueGoogle.data());
                if(ourGoogleDetail.uid == user.uid) {
                  FirebaseFirestore.instance.collection('googleAccounts').doc(ourGoogleDetail.uid).update({
                    'enroll': true
                  }).whenComplete(() {
                    checkEnroll = !checkEnroll;
                    showDialogError(
                      context,
                      successfully,
                      congratulationsRegistrationCourse,
                      "Okay",
                      isDarkMode,
                      "assets/images/10470-confirm.json",
                      18,
                      () {
                        Navigator.of(context).pop();
                      }
                    );
                  });
                } else {
                  snapshotFacebook.docs.forEach((snapValueFacebook) {
                    if(snapValueFacebook != null) {
                      OurFacebookDetail ourFacebookDetail = OurFacebookDetail.fromMap(snapValueFacebook.data());
                      if(ourFacebookDetail.uid == user.uid) {
                        FirebaseFirestore.instance.collection('facebookAccounts').doc(ourFacebookDetail.uid).update({
                          'enroll': true
                        }).whenComplete(() {
                          checkEnroll = !checkEnroll;
                          showDialogError(
                            context,
                            successfully,
                            congratulationsRegistrationCourse,
                            "Okay",
                            isDarkMode,
                            "assets/images/10470-confirm.json",
                            18,
                            () {
                              Navigator.of(context).pop();
                            }
                          );
                        });
                      }
                    }
                  });
                }
              }
            });
          }
        }
      });
    } else {
      showDialogError(
        context,
        error,
        errorRegistrationCourse,
        "Okay",
        isDarkMode,
        "assets/images/38213-error.json",
        18,
        () {
          Navigator.of(context).pop();
        }
      );
    }
  } else {
    displayToastMessage(context, pleaseConnectToTheInternet);
  }
}