import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/Screens/questions_screen/components/progress_time_bar.dart';
import 'package:code_edu/Screens/questions_screen/components/question_card.dart';
import 'package:code_edu/data/question_category.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final CategoryNotifier category;

  const Body({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final db = FirebaseFirestore.instance;
  List<QuestionCategory> _questionCategoryList = [];
  bool _showQuestionCard = false;
  double ratio = 10 / 100;
  bool _chooseAnswer = false;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    if(_showQuestionCard == false) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 15
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/icon-app.png",
                        width: 40,
                        height: 40,
                        alignment: Alignment.centerLeft,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Text(
                              widget.category.currentCategory.fullNameCourses,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "The test has 50 multiple choice questions.\nTake the test in 60 minutes.",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                          setState(() {
                            _showQuestionCard = true;
                          });
                        },
                        child: Text(
                          "Start",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue
                          ),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      TextButton(
                        onPressed: (){
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue
                          ),
                        ),
                      ),
                      const SizedBox(width: 8,),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return WillPopScope(
        onWillPop: () => showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: Text("Warning"),
            content: Text("Do you really want to exit"),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                child: Text('Yes'),
                onPressed: () => Navigator.pop(c, true),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.pop(c, false),
              ),
            ],
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10
                ),
                child: ProgressBar(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: StreamBuilder<QuerySnapshot>(
                  stream: db.collection('Courses').doc(widget.category.currentCategory.courseID).collection('QNA').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      var doc = snapshot.data.docs;
                      doc.forEach((element) {
                        QuestionCategory questionCategory = QuestionCategory.fromMap(element.data());
                        _questionCategoryList.add(questionCategory);
                        shuffle(_questionCategoryList);
                      });
                      return Column(
                        children: [
                          ...List.generate(
                            doc.length > 50 ? 50 : doc.length,
                            (index) {
                              return CardOptions(
                                numberQuestion: index + 1,
                                questions: _questionCategoryList[index].question.replaceAll(r'\n', '\n'),
                                options: _questionCategoryList[index].options,
                                chooseAnswer: _chooseAnswer,
                                answer: _questionCategoryList[index].answer,
                              );
                            }
                          )
                        ],
                      );
                    } else {
                      return LinearProgressIndicator();
                    }
                  }
                ),
              ),
              SizedBox(height: 20),
              BottomQuestionScreen(
                isChecked: _isChecked,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    }
  }
  List shuffle(List items) {
    var random = new Random();
    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }
    return items;
  }
}

// ignore: must_be_immutable
class BottomQuestionScreen extends StatefulWidget {
  bool isChecked;
  
  BottomQuestionScreen({
    Key key,
    @required this.isChecked,
  }) : super(key: key);

  @override
  _BottomQuestionScreenState createState() => _BottomQuestionScreenState();
}

class _BottomQuestionScreenState extends State<BottomQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: widget.isChecked,
                  onChanged: (bool newValue) {
                    setState(() {
                      widget.isChecked = newValue;
                    });
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "I want to finish the exam.",
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 13),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: 18
                )
              ),
              onPressed: widget.isChecked == false ? null : (){
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              child: Text(
                "Submit",
              )
            ),
          ),
        ],
      ),
    );
  }
}

// // ignore: must_be_immutable
// class CardOptions extends StatefulWidget {
//   final String questions;
//   final int numberQuestion;
//   final List options;
//   bool chooseAnswer;

//   CardOptions({
//     Key key,
//     @required this.questions,
//     @required this.numberQuestion,
//     @required this.options,
//     @required this.chooseAnswer,
//   }) : super(key: key);

//   @override
//   _CardOptionsState createState() => _CardOptionsState();
// }

// class _CardOptionsState extends State<CardOptions> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 15),
//       child: Card(
//         color: Colors.grey[50],
//         child: Padding(
//           padding: const EdgeInsets.only(
//             top: 15,
//             left: 20,
//             right: 8,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Q${widget.numberQuestion}. " + widget.questions,
//                 style: TextStyle(
//                   fontSize: 17,
//                   color: Colors.black,
//                   height: 1.3
//                 ),
//               ),
//               SizedBox(height: 20),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: widget.options.length,
//                 itemBuilder: (context, optionsIndex) {
//                   OptionsCategory optionsCategory = OptionsCategory.fromJson(widget.options[optionsIndex]);
//                   return QuestionScreen(
//                     option: optionsCategory.nameOption != null ? optionsCategory.nameOption : "",
//                     detailOption: optionsCategory.detailOption != null ? optionsCategory.detailOption : "",
//                     chooseAnswer: widget.chooseAnswer,
//                   );
//                 }
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }