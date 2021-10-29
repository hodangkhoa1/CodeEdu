import 'package:code_edu/Screens/home/components/bottom_navigation_bar.dart';
import 'package:code_edu/Screens/learn_course/learn_course.dart';
import 'package:code_edu/Screens/note_page/note_screen.dart';
import 'package:code_edu/Screens/quiz_app/quiz_app_screen.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/Screens/side_bar/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:code_edu/Screens/home/components/body.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class HomeScreen extends StatefulWidget {
  final String urlImage;
  final String nameUser;
  final String nameUniversity;
  final String emailUser;
  final String phoneNumber;
  final bool showBottomBar;
  final String uid;
  final DateTime dateOfBirth;

  const HomeScreen({
    Key key,
    @required this.urlImage,
    @required this.nameUser,
    @required this.nameUniversity,
    @required this.emailUser,
    @required this.phoneNumber,
    @required this.showBottomBar,
    @required this.uid,
    @required this.dateOfBirth
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBar(
        urlImage: widget.urlImage,
        nameUser: widget.nameUser != null ? widget.nameUser : "Anonymous",
        nameUniversity: widget.nameUniversity,
        emailUser: widget.emailUser,
        phoneNumber: widget.phoneNumber,
        uid: widget.uid,
        dateOfBirth: widget.dateOfBirth,
      ),
      body: Body(
        onTapAvatar: () => _scaffoldKey.currentState.openDrawer(),
        urlAvatar: widget.urlImage,
        nameTextAppBar: widget.nameUser,
        showBottomBar: widget.showBottomBar,
        uid: widget.uid,
      ),
      bottomNavigationBar: Stack(
        children: [
          _index == 0 ? Body(
            onTapAvatar: () => _scaffoldKey.currentState.openDrawer(),
            urlAvatar: widget.urlImage,
            nameTextAppBar: widget.nameUser,
            showBottomBar: widget.showBottomBar,
            uid: widget.uid,
          ) : (_index == 1 ? CodeAppScreen(
            urlImage: widget.urlImage,
            emailUser: widget.emailUser,
            nameUniversity: widget.nameUniversity,
            nameUser: widget.nameUser != null ? widget.nameUser : "Anonymous",
            phoneNumber: widget.phoneNumber,
            uid: widget.uid,
            dateOfBirth: widget.dateOfBirth,
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