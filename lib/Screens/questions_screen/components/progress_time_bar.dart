import 'package:code_edu/Screens/questions_screen/components/controllers/animated_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF3F4768),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(50),
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
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF46A0AE),
                        Color(0xFF00FFCB),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(50)
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
                        "${(controller.animation.value * 60).round()} sec",
                        style: TextStyle(
                          color: Colors.white
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