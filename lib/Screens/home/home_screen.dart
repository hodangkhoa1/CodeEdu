import 'package:code_edu/Screens/home/components/body.dart';
import 'package:code_edu/Screens/home/components/bottom_navigation_bar.dart';
import 'package:code_edu/Screens/home/components/side_bar.dart';
import 'package:code_edu/Screens/quiz_app/quiz_app_screen.dart';
import 'package:code_edu/Screens/something_wrong/something_wrong_screen.dart';
import 'package:code_edu/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: CustomAppBar(
        height: 60.0,
        urlImage: "assets/images/avatar.png",
        textAppBar: "Hello Khoa!",
        iconAppBar: Icons.help_outline,
        iconColorAppBar: Colors.black,
      ),
      body: Body(),
      bottomNavigationBar: Stack(
        children: [
          _index == 0 ? Body() : (_index == 1 ? SomethingWrongScreen() : _index == 2 ? QuizApp() : SomethingWrongScreen()),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 16),
              decoration: BoxDecoration(
                color: Colors.lightBlue
              ),
              child: Row(
                children: <Widget>[
                  NavigationBarBottom(
                    onTap: () {
                      setState(() {
                        _index = 0;
                      });
                    },
                    borderColor: _index == 0 ? Colors.white : Colors.transparent,
                    icon: Icons.home_outlined,
                    iconColor: _index == 0 ? Colors.blue : Colors.white,
                    text: _index == 0 ? "Home" : "",
                    textColor: _index == 0 ? Colors.blue : Colors.white,
                  ),
                  Spacer(),
                  NavigationBarBottom(
                    onTap: () {
                      setState(() {
                         _index = 1;
                      });
                    },
                    borderColor: _index == 1 ? Colors.white : Colors.transparent,
                    icon: Icons.code_outlined,
                    iconColor: _index == 1 ? Colors.blue : Colors.white,
                    text: _index == 1 ? "Code" : "",
                    textColor: _index == 1 ? Colors.blue : Colors.white,
                  ),
                  Spacer(),
                  NavigationBarBottom(
                    onTap: () {
                      setState(() {
                        _index = 2;
                      });
                    },
                    borderColor: _index == 2 ? Colors.white : Colors.transparent,
                    icon: Icons.quiz_outlined,
                    iconColor: _index == 2 ? Colors.blue : Colors.white,
                    text: _index == 2 ? "Quiz" : "",
                    textColor: _index == 2 ? Colors.blue : Colors.white,
                  ),
                  Spacer(),
                  NavigationBarBottom(
                    onTap: () {
                      setState(() {
                        _index = 3;
                      });
                    },
                    borderColor: _index == 3 ? Colors.white : Colors.transparent,
                    icon: Icons.notifications_none,
                    iconColor: _index == 3 ? Colors.blue : Colors.white,
                    text: _index == 3 ? "Notify" : "",
                    textColor: _index == 3 ? Colors.blue : Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}