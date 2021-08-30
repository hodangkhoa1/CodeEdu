// import 'package:code_edu/Screens/questions_screen/components/controllers/animated_progress_bar.dart';
// import 'package:code_edu/Screens/questions_screen/components/option.dart';
// import 'package:code_edu/data/questions.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class QuestionCard extends StatelessWidget {
//   final Question question;
  
//   const QuestionCard({
//     Key key,
//     @required this.question,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     QuestionController _controller = Get.put(QuestionController());
//     return Container(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 7),
//           child: Column(
//             children: [
//               SizedBox(height: 10),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   question.question,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16
//                   ),
//                 ),
//               ),
//               SizedBox(height: 8),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Choose your answer from below",
//                   style: TextStyle(
//                     fontStyle: FontStyle.italic,
//                     fontSize: 16
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40),
//               ...List.generate(
//                 question.options.length,
//                 (index) => Option(
//                   index: index,
//                   text: question.options[index],
//                   press: () => _controller.checkAns(question, index),
//                 )
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:code_edu/Screens/questions_screen/components/option.dart';
import 'package:code_edu/data/question_category.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardOptions extends StatefulWidget {
  final String questions;
  final int numberQuestion;
  final List options;
  bool chooseAnswer;
  final int answer;

  CardOptions({
    Key key,
    @required this.questions,
    @required this.numberQuestion,
    @required this.options,
    @required this.chooseAnswer,
    @required this.answer,
  }) : super(key: key);

  @override
  _CardOptionsState createState() => _CardOptionsState();
}

class _CardOptionsState extends State<CardOptions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Card(
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
            left: 20,
            right: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Q${widget.numberQuestion}. " + widget.questions,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  height: 1.3
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.options.length,
                itemBuilder: (context, optionsIndex) {
                  OptionsCategory optionsCategory = OptionsCategory.fromJson(widget.options[optionsIndex]);
                  return QuestionScreen(
                    option: optionsCategory.nameOption != null ? optionsCategory.nameOption : "",
                    detailOption: optionsCategory.detailOption != null ? optionsCategory.detailOption : "",
                    answer: widget.answer,
                    optionID: optionsCategory.optionID,
                    //groupValue: optionsCategory.optionID,
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}