import 'package:code_edu/Screens/questions_screen/components/controllers/animated_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Score",
                style: Theme.of(context).textTheme.headline3.copyWith(color: Color(0xFF8B94BC)),
              ),
              Spacer(),
              Text(
                "${_questionController.correctAnswered * 10}/${_questionController.questions.length * 10}",
                style: Theme.of(context).textTheme.headline4.copyWith(color: Color(0xFF8B94BC)),
              ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}