import 'package:code_edu/Screens/complete_sign_up/components/complete_sign_up_form.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 25),
                Text(
                  "Complete Profile",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                Text(
                  "Complete your details or continue \nwith social media",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Color(0xFF8B8B8B)),
                ),
                CompleteProfileForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}