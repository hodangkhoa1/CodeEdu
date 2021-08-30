import 'package:code_edu/Screens/learn_course/components/body.dart';
import 'package:code_edu/Screens/side_bar/side_bar.dart';
import 'package:flutter/material.dart';

class LearnCourse extends StatefulWidget {
  final String urlImage;

  const LearnCourse({
    Key key,
    @required this.urlImage,
  }) : super(key: key);

  @override
  _LearnCourseState createState() => _LearnCourseState();
}

class _LearnCourseState extends State<LearnCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      body: Body(
        urlImage: widget.urlImage,
      ),
    );
  }
}