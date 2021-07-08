import 'package:code_edu/Screens/questions_screen/components/controllers/animated_progress_bar.dart';
import 'package:code_edu/Screens/questions_screen/components/progress_time_bar.dart';
import 'package:code_edu/Screens/questions_screen/components/question_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  const Body({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Obx(
            () => Text.rich(
              TextSpan(
                text: "Question ${_questionController.questionNumber.value}",
                style: Theme.of(context).textTheme.headline4.copyWith(color: Color(0xFF8B94BC)),
                children: [
                  TextSpan(
                    text: "/${_questionController.questions.length}",
                    style: Theme.of(context).textTheme.headline5.copyWith(color: Color(0xFF8B94BC))
                  )
                ]
              )
            )
          ),
          SizedBox(height: 25),
          ProgressBar(),
          SizedBox(height: 45),
          Expanded(
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: _questionController.pageController,
              onPageChanged: _questionController.updateTheQuestionsNumber,
              itemCount: _questionController.questions.length,
              itemBuilder: (context, index) => QuestionCard(
                question: _questionController.questions[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}