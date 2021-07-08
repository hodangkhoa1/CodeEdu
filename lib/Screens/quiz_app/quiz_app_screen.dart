import 'package:code_edu/Screens/home/components/side_bar.dart';
import 'package:code_edu/Screens/quiz_app/components/body.dart';
import 'package:code_edu/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: CustomAppBar(
        height: 60.0,
        urlImage: "assets/images/avatar.png",
        textAppBar: "Quiz",
        iconAppBar: Icons.settings,
        iconColorAppBar: Colors.lightBlue,
      ),
      body: Body(),
    );
  }
}