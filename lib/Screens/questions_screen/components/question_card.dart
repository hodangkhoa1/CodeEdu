import 'package:code_edu/Screens/questions_screen/components/controllers/animated_progress_bar.dart';
import 'package:code_edu/Screens/questions_screen/components/option.dart';
import 'package:code_edu/data/questions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  
  const QuestionCard({
    Key key,
    @required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            children: [
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  question.question,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose your answer from below",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16
                  ),
                ),
              ),
              SizedBox(height: 40),
              ...List.generate(
                question.options.length,
                (index) => Option(
                  index: index,
                  text: question.options[index],
                  press: () => _controller.checkAns(question, index),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}