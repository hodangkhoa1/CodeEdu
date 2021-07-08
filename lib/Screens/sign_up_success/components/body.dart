import 'package:code_edu/components/rounded_button.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(height: size.height * 0.04),
        Image.asset(
          "assets/images/Success.gif",
          height: size.height * 0.4,
        ),
        SizedBox(height: size.height * 0.08),
        Text(
          "SignUp Success",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: size.width * 0.6,
          child: RoundeButton(
            text: "Back to home",
            press: (){},
          ),
        ),
        Spacer(),
      ],
    );
  }
}