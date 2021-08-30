import 'package:code_edu/Screens/code_app/code_app_screen.dart';
import 'package:code_edu/Screens/home/components/body.dart';
import 'package:code_edu/Screens/home/components/bottom_navigation_bar.dart';
import 'package:code_edu/Screens/learn_course/learn_course.dart';
import 'package:code_edu/Screens/quiz_app/quiz_app_screen.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/Screens/side_bar/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class HomeScreen extends StatefulWidget {
  final String urlImage;
  final String nameTextAppBar;
  final String emailGoogleLogin;
  final String showBottomBar;

  const HomeScreen({
    Key key,
    this.urlImage,
    this.nameTextAppBar,
    this.emailGoogleLogin,
    this.showBottomBar,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    return Scaffold(
      drawer: SideBar(
        urlImage: widget.urlImage,
        nameGoogleLogin: (widget.nameTextAppBar != null) ? widget.nameTextAppBar : "Anonymous",
        emailGoogleLogin: (widget.emailGoogleLogin != null) ? widget.emailGoogleLogin : "",
      ),
      body: Body(
        showBottomBar: widget.showBottomBar,
        urlAvatar: widget.urlImage,
        nameTextAppBar: widget.nameTextAppBar,
      ),
      bottomNavigationBar: Stack(
        children: [
          _index == 0 ? Body(
            showBottomBar: widget.showBottomBar,
            urlAvatar: widget.urlImage,
            nameTextAppBar: widget.nameTextAppBar,
          ) : (_index == 1 ? CodeAppScreen(
            urlImage: widget.urlImage,
          ) : _index == 2 ? QuizApp(
            urlImage: widget.urlImage,
          ) : LearnCourse(
            urlImage: widget.urlImage,
          )),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 1.0
                  )
                ),
                color: isDarkMode ? Color(0xFF181818) : Colors.lightBlue,
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
                    icon: Icons.menu_book,
                    iconColor: _index == 3 ? Colors.blue : Colors.white,
                    text: _index == 3 ? "Learn" : "",
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