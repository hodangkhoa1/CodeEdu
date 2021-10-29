import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/Screens/detail_courses/components/course_content_list.dart';
import 'package:code_edu/Screens/detail_courses/components/custom_bottom_navigation_bar.dart';
import 'package:code_edu/Screens/detail_courses/components/enroll_function.dart';
import 'package:code_edu/Screens/detail_courses/components/header_detail_course.dart';
import 'package:code_edu/data/category.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailCoursesScreen extends StatefulWidget {
  final bool showBottomBar;
  final String urlAvatar;
  final bool isDarkMode;
  final String uid;
  final String titleCourse;
  final String authorCourse;
  final double startCourse;

  const DetailCoursesScreen({
    Key key,
    @required this.showBottomBar,
    @required this.urlAvatar,
    @required this.isDarkMode,
    @required this.uid,
    @required this.titleCourse,
    @required this.authorCourse,
    @required this.startCourse
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
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context, listen: false);
    bool _checkEnroll = widget.showBottomBar;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: widget.isDarkMode ? LinearGradient(
            colors: [
              Color(0xFF181818).withOpacity(0.9),
              Color(0xFF3C4043),
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
          ) : LinearGradient(
            colors: [
              Color(0xFF0F17AD).withOpacity(0.9),
              Color(0xFF6985E8),
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          children: [
            HeaderDetailCourse(
              onTap: () {
                Get.back();
              },
              titleCourse: widget.titleCourse,
              startCourse: widget.startCourse,
              authorCourse: "Author: ${widget.authorCourse}"
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: widget.isDarkMode ? Color(0xFF181818) : Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70)
                  )
                ),
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: db.collection('Courses').doc(categoryNotifier.currentCategory.courseID).collection('CoursesContent').snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        var doc = snapshot.data.docs;
                        doc.forEach((element) {
                          CoursesDetail courseContent = CoursesDetail.fromMap(element.data());
                          _courseContent.add(courseContent);
                        });
                        return Column(
                          children: [
                            SizedBox(height: 30),
                            Row(
                              children: [
                                SizedBox(width: 30),
                                Text(
                                  "Total: ${doc.length} lessons",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: widget.isDarkMode ? Color(0xFF9999A9) : Color(0xFF2F2F51)
                                  ),
                                ),
                                Expanded(child: Container()),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.loop,
                                      size: 30,
                                      color: Color(0xFF6D8DEA),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Reset",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF9999A9)
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 40)
                              ],
                            ),
                            SizedBox(height: 20),
                            CourseContentList(
                              courseDetail: _courseContent,
                              isDarkMode: widget.isDarkMode,
                              isDone: _checkEnroll,
                              doc: doc,
                              urlAvatar: widget.urlAvatar,
                            )
                          ],
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  )
                ),
              )
            )
          ],
        ),
      ),
      bottomNavigationBar: _checkEnroll == false ? CustomBottomNavigationBar(
        isDarkMode: widget.isDarkMode,
        onTap: () => enrollFunction(
          context,
          widget.isDarkMode,
          _checkEnroll,
          isoffline,
          AppLocalizations.of(context).successfully,
          AppLocalizations.of(context).congratulationsRegistrationCourse,
          AppLocalizations.of(context).errorSupportTitle,
          AppLocalizations.of(context).errorRegistrationCourse,
          AppLocalizations.of(context).pleaseConnectToTheInternet
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