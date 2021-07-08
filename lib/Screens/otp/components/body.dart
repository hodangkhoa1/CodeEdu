import 'package:code_edu/Screens/otp/components/otp_form.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05),
              Text("OTP Verification", style: TextStyle(fontSize: 26)),
              SizedBox(height: 10),
              Text("We sent your code to your number phone"),
              SizedBox(height: 10),
              buildTimer(),
              SizedBox(height: size.height * 0.15),
              OtpForm(),
              SizedBox(height: size.height * 0.1),
              GestureDetector(
                onTap: () {
                  // Gửi lại mã code OTP
                },
                child: Text(
                  "Resend OTP code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0),
          duration: Duration(seconds: 30), // because we allow user 30s
          builder: (context, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Colors.orange),
          ),
          onEnd: () {},
        )
      ],
    );
  }
}