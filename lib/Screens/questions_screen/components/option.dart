// import 'package:code_edu/Screens/questions_screen/components/controllers/animated_progress_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Option extends StatelessWidget {
//   final String text;
//   final String code;
//   final VoidCallback press;
//   final int index;

//   const Option({
//     Key key,
//     this.text,
//     this.press,
//     this.code,
//     this.index,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<QuestionController>(
//       init: QuestionController(),
//       builder: (controller) {
//         Color getTheRightColor() {
//           if(controller.isAnswered) {
//             if(index == controller.correctAnswered) {
//               return Colors.green;
//             } else if(index == controller.selectedAnswered && controller.selectedAnswered != controller.correctAnswered) {
//               return Colors.red;
//             }
//           }
//           return Colors.grey.shade200;
//         }
//         IconData getTheRightIcon() {
//           return getTheRightColor() == Colors.red ? Icons.close : Icons.done;
//         }
//         Color getTheRightIconBackground() {
//           return getTheRightIcon() == null ? Colors.transparent : Colors.white;
//         }
//         return Padding(
//           padding: EdgeInsets.symmetric(vertical: 12),
//           child: InkWell(
//             onTap: press,
//             child: Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: getTheRightColor(),
//                 borderRadius: BorderRadius.circular(16)
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 50,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               "${index + 1}.",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                                 color: Colors.black
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             Text(
//                               "$text",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.black
//                               ),
//                             )
//                           ],
//                         ),
//                         Container(
//                           height: 30,
//                           width: 30,
//                           decoration: BoxDecoration(
//                             color: getTheRightColor() == Colors.grey.shade200 ? Colors.transparent : getTheRightColor(),
//                             borderRadius: BorderRadius.circular(50)
//                           ),
//                           child: getTheRightColor() == Colors.grey.shade200 ? null : Icon(
//                             getTheRightIcon(),
//                             size: 26,
//                             color: getTheRightIconBackground(),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//     );
//   }
// }

//import 'package:code_edu/Screens/questions_screen/components/controllers/animated_progress_bar.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';

// ignore: must_be_immutable
class QuestionScreen extends StatefulWidget {
  final String option;
  final String detailOption;
  //bool chooseAnswer;
  //final String selectedString;
  //final int selectedString;
  final int answer;
  int optionID;

  QuestionScreen({
    Key key,
    @required this.option,
    @required this.detailOption,
    //@required this.chooseAnswer,
    //@required this.selectedString,
    @required this.answer,
    @required this.optionID,
  }) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int valueChoose;
  @override
  Widget build(BuildContext context) {
    //QuestionController _controller = Get.put(QuestionController());
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: RadioListTile(
          title: Text(
            widget.option + " " + widget.detailOption,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
          ),
          value: widget.optionID,
          groupValue: valueChoose,
          onChanged: (newOptionID) {
            setState(() {
              valueChoose = newOptionID;
              //_controller.checkAns(widget.answer, valueChoose);
              print(valueChoose);
            });
          }
        ),
      ),
    );
    // return GestureDetector(
    //   onTap: (){
    //     if(widget.chooseAnswer == false) {
    //       setState(() {
    //         widget.chooseAnswer = true;
    //       });
    //     } else {
    //       setState(() {
    //         widget.chooseAnswer = false;
    //       });
    //     }
    //     if (widget.chooseAnswer == true) {
    //       setState(() {
    //         _controller.checkAns(widget.answer, widget.selectedString);
    //       });
    //     }
    //   },
    //   child: Container(
    //     child: Padding(
    //       padding: EdgeInsets.only(bottom: 20),
    //       child: Row(
    //         children: [
    //           Container(
    //             height: 30,
    //             width: 30,
    //             alignment: Alignment.center,
    //             decoration: BoxDecoration(
    //               border: Border.all(
    //                 color: widget.chooseAnswer == false ? Colors.grey : Colors.blue
    //               ),
    //               borderRadius: BorderRadius.circular(24),
    //               color: widget.chooseAnswer == false ? Colors.white : Colors.blue
    //             ),
    //             child: Text(
    //               widget.option,
    //               style: TextStyle(
    //                 color: widget.chooseAnswer == false ? Colors.grey : Colors.white
    //               ),
    //             ),
    //           ),
    //           SizedBox(width: 12),
    //           Expanded(
    //             child: Text(
    //               widget.detailOption,
    //               style: TextStyle(
    //                 fontSize: 17,
    //                 color: Colors.black54
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}