import 'package:code_edu/Screens/Login/login_screen.dart';
import 'package:code_edu/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Body extends StatefulWidget {
  final bool isDarkMode;

  const Body({
    Key key,
    @required this.isDarkMode
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin{
  AnimationController _successfulController;

  @override
  void initState() {
    _successfulController = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _successfulController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: <Widget>[
          Lottie.asset(
            "assets/images/10470-confirm.json",
            height: size.height * 0.4,
            controller: _successfulController,
            onLoaded: (animation) {
              _successfulController..duration = animation.duration..repeat(
                reverse: true
              );
            },
          ),
          SizedBox(height: size.height * 0.08),
          Text(
            "SignUp Success",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Text(
            "Email verification link has sent to your email.",
            style: TextStyle(
              fontSize: 16
            ),
          ),
          Spacer(),
          SizedBox(
            width: size.width * 0.6,
            child: RoundeButton(
              text: "Back to Login",
              press: (){
                setState(() {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginScreen(
                    isDarkMode: widget.isDarkMode,
                  )), (route) => false);
                });
              },
              color: widget.isDarkMode ? Colors.grey : Colors.blue,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}