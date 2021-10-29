import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final BorderRadiusGeometry borderRadius;
  final TextEditingController textEditingController;
  final List<String> errors;

  const TextFieldContainer({
    Key key, 
    @required this.child,
    @required this.color,
    @required this.borderRadius,
    @required this.textEditingController,
    @required this.errors
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          color: (textEditingController.text.trim().isNotEmpty || errors.isNotEmpty) ? color : Colors.grey,
          width: 1.0
        ),
      ),
      child: child,
    );
  }
}