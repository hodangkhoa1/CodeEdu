import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: List.generate(errors.length, (index) => formErrorText(error: errors[index])),
      ),
    );
  }

  Row formErrorText({String error}) {
    return Row(
        children: [
          SvgPicture.asset(
            "assets/icons/error.svg",
            height: 16,
            width: 16,
          ),
          SizedBox(
            width: 10,
          ),
          Text(error),
        ],
      );
  }
}