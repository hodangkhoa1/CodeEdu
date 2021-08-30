import 'package:code_edu/Screens/questions_screen/components/controllers/animated_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    Key key,
  }) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF3F4768),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (controller) {
          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  width: constraints.maxWidth * controller.animation.value,
                  decoration: BoxDecoration(
                    color: (controller.animation.value * 60 < 5) ? Colors.red : (controller.animation.value * 60 < 15) ? Colors.amber[400] : Color(0xFF46A0AE),
                    borderRadius: BorderRadius.circular(2)
                  ),
                )
              ),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${(controller.animation.value * 60).round()} minutes",
                        style: TextStyle(
                          color: (controller.animation.value * 60 < 5) ? Colors.black : (controller.animation.value * 60 < 15) ? Colors.black : Colors.white
                        ),
                      ),
                      SvgPicture.asset("assets/icons/clock.svg")
                    ],
                  ),
                )
              ),
            ]
          );
        }
      ),
    );
  }
}