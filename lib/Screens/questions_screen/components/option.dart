import 'package:code_edu/Screens/questions_screen/components/controllers/animated_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Option extends StatelessWidget {
  final String text;
  final String code;
  final VoidCallback press;
  final int index;

  const Option({
    Key key,
    this.text,
    this.press,
    this.code,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(),
      builder: (controller) {
        Color getTheRightColor() {
          if(controller.isAnswered) {
            if(index == controller.correctAnswered) {
              return Colors.green;
            } else if(index == controller.selectedAnswered && controller.selectedAnswered != controller.correctAnswered) {
              return Colors.red;
            }
          }
          return Colors.grey.shade200;
        }
        IconData getTheRightIcon() {
          return getTheRightColor() == Colors.red ? Icons.close : Icons.done;
        }
        Color getTheRightIconBackground() {
          return getTheRightIcon() == null ? Colors.transparent : Colors.white;
        }
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: InkWell(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: getTheRightColor(),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${index + 1}.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "$text",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: getTheRightColor() == Colors.grey.shade200 ? Colors.transparent : getTheRightColor(),
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: getTheRightColor() == Colors.grey.shade200 ? null : Icon(
                            getTheRightIcon(),
                            size: 26,
                            color: getTheRightIconBackground(),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}