import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/components/display_toast_message.dart';
import 'package:code_edu/components/show_dialog_error.dart';
import 'package:code_edu/data/facebookAccount.dart';
import 'package:code_edu/data/googleAccount.dart';
import 'package:code_edu/data/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> GetValueDatabase(BuildContext context, String userID, bool isDarkMode, bool isoffline, String successfully,
    String congratulationsRegistrationCourse, String email, String fullName, String nameUniversity, String phoneNumber,
    String urlImage, DateTime dateOfBirth, String error, String errorRegistrationCourse) async {
  if(isoffline == false) {
    if(userID != null) {
      QuerySnapshot snapshotUser = await FirebaseFirestore.instance.collection('users').get();
      QuerySnapshot snapshotGoogle = await FirebaseFirestore.instance.collection('googleAccounts').get();
      QuerySnapshot snapshotFacebook = await FirebaseFirestore.instance.collection('facebookAccounts').get();
      snapshotUser.docs.forEach((snapValueUser) {
        if(snapValueUser != null) {
          OurUserDetail ourUserDetail = OurUserDetail.fromMap(snapValueUser.data());
          if(ourUserDetail.uid == userID) {
            FirebaseFirestore.instance.collection('users').doc(ourUserDetail.uid).update({
              'email': email,
              'fullName': fullName,
              'nameUniversity': nameUniversity,
              'phoneNumber': phoneNumber,
              'urlImage': urlImage,
              'dateOfBirth': dateOfBirth,
            }).whenComplete(() {
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
                if(ourGoogleDetail.uid == userID) {
                  FirebaseFirestore.instance.collection('googleAccounts').doc(ourGoogleDetail.uid).update({
                    'email': email,
                    'fullName': fullName,
                    'nameUniversity': nameUniversity,
                    'phoneNumber': phoneNumber,
                    'urlImage': urlImage,
                    'dateOfBirth': dateOfBirth,
                  }).whenComplete(() {
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
                      if(ourFacebookDetail.uid == userID) {
                        FirebaseFirestore.instance.collection('facebookAccounts').doc(ourFacebookDetail.uid).update({
                          'email': email,
                          'fullName': fullName,
                          'nameUniversity': nameUniversity,
                          'phoneNumber': phoneNumber,
                          'urlImage': urlImage,
                          'dateOfBirth': dateOfBirth,
                        }).whenComplete(() {
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
      print("Lỗi");
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
    displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
  }
}