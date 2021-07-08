import 'package:code_edu/Screens/Login/login_screen.dart';
import 'package:code_edu/Screens/Signup/signup_screen.dart';
import 'package:code_edu/Screens/Welcome/components/background.dart';
import 'package:code_edu/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO CODE EDU",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/code-welcome.svg",
              height: size.height * 0.4,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundeButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundeButton(
              text: "SIGN UP",
              color: Color.fromARGB(130, 30, 144, 255), //(150, 30, 144, 255)
              textColor: Colors.white,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
