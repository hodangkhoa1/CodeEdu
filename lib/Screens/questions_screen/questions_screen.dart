import 'package:code_edu/Screens/questions_screen/components/body.dart';
import 'package:code_edu/Screens/questions_screen/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({
    Key key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        height: 60,
      ),
      body: Body(),
    );
  }
}