import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/Screens/detail_courses/components/course_content.dart';
import 'package:code_edu/Screens/detail_courses/components/show_dialog_choose_options.dart';
import 'package:code_edu/data/category.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CourseContentList extends StatefulWidget {
  final FirebaseFirestore db;
  final CategoryNotifier categoryNotifier;
  final List<CoursesDetail> courseDetail;
  final String urlAvatar;
  final bool isDarkMode;
  final bool isDone;

  const CourseContentList({
    Key key,
    @required this.db,
    @required this.categoryNotifier,
    @required this.courseDetail,
    @required this.urlAvatar,
    @required this.isDarkMode,
    @required this.isDone,
  }) : super(key: key);

  @override
  _CourseContentListState createState() => _CourseContentListState();
}

class _CourseContentListState extends State<CourseContentList> with TickerProviderStateMixin {
  AnimationController _notFoundController;

  @override
  void initState() {
    _notFoundController = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _notFoundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.db.collection('Courses').doc(widget.categoryNotifier.currentCategory.courseID).collection('CoursesContent').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          var doc = snapshot.data.docs;
          doc.forEach((element) {
            CoursesDetail courseContent = CoursesDetail.fromMap(element.data());
            widget.courseDetail.add(courseContent);
          });
          return Column(
            children: [
              widget.courseDetail.isNotEmpty ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: doc.length,
                itemBuilder: (BuildContext context, int index) {
                  return CourseContent(
                    hours: widget.courseDetail[index].hours,
                    minutes: widget.courseDetail[index].minutes,
                    seconds: widget.courseDetail[index].seconds,
                    isDone: widget.isDone,
                    number: index < 9 ? "0${index + 1}" : "${index + 1}",
                    title: widget.courseDetail[index].title,
                    onTap: () {
                      setState(() {
                        showDialogChooseOptions(
                          context,
                          widget.courseDetail[index].urlVideo,
                          widget.courseDetail[index].urlPDF,
                          widget.urlAvatar,
                          widget.courseDetail[index].title,
                          widget.isDarkMode
                        );
                      });
                    },
                  );
                }
              ) : Lottie.asset(
                "assets/images/38061-search.json",
                height: MediaQuery.of(context).size.height * 0.30,
                controller: _notFoundController,
                onLoaded: (animation) {
                  _notFoundController..duration = animation.duration..repeat(
                    reverse: true
                  );
                },
              )
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 30),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}