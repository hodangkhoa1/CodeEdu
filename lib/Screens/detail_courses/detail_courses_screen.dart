import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/AllWidgets/display_toast_message.dart';
import 'package:code_edu/AllWidgets/show_dialog_error.dart';
import 'package:code_edu/Screens/detail_courses/components/course_content_list.dart';
import 'package:code_edu/Screens/detail_courses/components/custom_app_bar.dart';
import 'package:code_edu/Screens/detail_courses/components/custom_bottom_navigation_bar.dart';
import 'package:code_edu/Screens/detail_courses/components/top_rounded_container.dart';
import 'package:code_edu/data/category.dart';
import 'package:code_edu/data/facebookAccount.dart';
import 'package:code_edu/data/googleAccount.dart';
import 'package:code_edu/data/user.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailCoursesScreen extends StatefulWidget {
  final bool showBottomBar;
  final String urlAvatar;
  final bool isDarkMode;
  final String uid;

  const DetailCoursesScreen({
    Key key,
    @required this.showBottomBar,
    @required this.urlAvatar,
    @required this.isDarkMode,
    @required this.uid,
  }) : super(key: key);

  @override
  _DetailCoursesScreenState createState() => _DetailCoursesScreenState();
}

class _DetailCoursesScreenState extends State<DetailCoursesScreen> {
  final db = FirebaseFirestore.instance;
  List<CoursesDetail> _courseContent = [];
  bool isoffline = false;
  StreamSubscription internetconnection;

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
    super.initState();
  }

  @override
  void dispose() {
    internetconnection.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _checkEnroll = widget.showBottomBar;
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CustomAppBar(
            innerBoxIsScrolled: innerBoxIsScrolled,
            size: size,
            isDarkMode: widget.isDarkMode,
          ),
        ],
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1.80,
                        child: Image.network(
                          categoryNotifier.currentCategory.images,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TopRoundedContainer(
                      color: widget.isDarkMode ? Color(0xFF313131) : Colors.white,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "${categoryNotifier.currentCategory.fullNameCourses}" ?? "1",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 35, height: 28),
                              SvgPicture.asset(
                                "assets/icons/person.svg",
                                color: widget.isDarkMode ? Colors.blue : Colors.black,
                              ),
                              SizedBox(width: 5),
                              Text("${categoryNotifier.currentCategory.numberVisitors}K"),
                              SizedBox(width: 20),
                              SvgPicture.asset("assets/icons/Star Icon.svg"),
                              SizedBox(width: 5),
                              Text(
                                "${categoryNotifier.currentCategory.rating}" ?? "0",
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  AppLocalizations.of(context).courseContent,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  width: 64,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFE6E6),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)
                                    )
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/Heart Icon_2.svg",
                                    color: Color(0xFFFF4848),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(
                            height: 30,
                            thickness: 0.5,
                            color: widget.isDarkMode ? Colors.grey : Colors.black.withOpacity(0.3),
                            indent: 32,
                            endIndent: 32,
                          ),
                          SizedBox(height: 15),
                          CourseContentList(
                            categoryNotifier: categoryNotifier,
                            courseDetail: _courseContent,
                            db: db,
                            urlAvatar: widget.urlAvatar,
                            isDarkMode: widget.isDarkMode,
                            isDone: widget.showBottomBar,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _checkEnroll == false ? CustomBottomNavigationBar(
        isDarkMode: widget.isDarkMode,
        onTap: () => enrollFunction(
          context,
          widget.isDarkMode,
          widget.uid,
          _checkEnroll,
          isoffline,
          AppLocalizations.of(context).successfully,
          AppLocalizations.of(context).congratulationsRegistrationCourse,
          AppLocalizations.of(context).errorSupportTitle,
          AppLocalizations.of(context).errorRegistrationCourse,
        ),
      ) : Stack(
        children: [
          Container(
            height: 0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          )
        ]
      )
    );
  }
}

Future<void> enrollFunction(BuildContext context, bool isDarkMode, String uid, bool checkEnroll, bool isoffline, String successfully, String congratulationsRegistrationCourse, String error, String errorRegistrationCourse) async {
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
                isDarkMode
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
                      isDarkMode
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
                            isDarkMode
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
        isDarkMode
      );
    }
  } else {
    displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
  }
}