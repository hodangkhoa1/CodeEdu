import 'dart:async';

import 'package:code_edu/Screens/Login/login_screen.dart';
import 'package:code_edu/Screens/policy_terms_screen/policy_screen.dart';
import 'package:code_edu/Screens/profile/profile_screen.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/Screens/settings_screen/setting_screen.dart';
import 'package:code_edu/Screens/side_bar/components/build_header.dart';
import 'package:code_edu/Screens/side_bar/components/build_menu_item.dart';
import 'package:code_edu/Screens/software_information/software_information.dart';
import 'package:code_edu/Screens/to_do_app/home_to_do_page.dart';
import 'package:code_edu/Screens/update/update_screen.dart';
import 'package:code_edu/blocs/auth_bloc_facebook.dart';
import 'package:code_edu/blocs/auth_bloc_google.dart';
import 'package:code_edu/components/display_toast_message.dart';
import 'package:code_edu/components/progressDialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

class SideBar extends StatefulWidget {
  final String urlImage;
  final String nameUser;
  final String nameUniversity;
  final String emailUser;
  final String phoneNumber;
  final String uid;
  final DateTime dateOfBirth;

  const SideBar({
    Key key,
    @required this.urlImage,
    @required this.nameUser,
    @required this.emailUser,
    @required this.nameUniversity,
    @required this.phoneNumber,
    @required this.uid,
    @required this.dateOfBirth,
  }) : super(key: key);
  
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
  StreamSubscription<User> homeStateFacebook;
  StreamSubscription<User> homeStateGoogle;
  bool isoffline = false;
  StreamSubscription internetconnection;

  @override
  void initState() {
    internetconnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.none){
        setState(() {
          isoffline = true;
        });
      }else if(result == ConnectivityResult.mobile){
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        setState(() {
          isoffline = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    internetconnection.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: isDarkMode ? Color(0xFF212121) : Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            BuildHeader(
              urlImage: widget.urlImage,
              name: widget.nameUser,
              email: widget.emailUser,
              onClicked: (){
                setState(() {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      urlImage: widget.urlImage,
                      nameUser: widget.nameUser,
                      nameUniversity: widget.nameUniversity,
                      emailUser: widget.emailUser,
                      phoneNumber: widget.phoneNumber,
                      dateOfBirth: widget.dateOfBirth,
                    ),
                  ));
                });
              }
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  SizedBox(height: 12),
                  BuildMenuItem(
                    text: AppLocalizations.of(context).favourites,
                    icon: Icons.favorite_border,
                    color: Colors.pink,
                    onTap: () => selectedItem(context, 0),
                  ),
                  SizedBox(height: 16),
                  BuildMenuItem(
                    text: "Todoo",
                    icon: Icons.check_circle_outline,
                    color: Colors.white,
                    onTap: () => selectedItem(context, 1),
                  ),
                  SizedBox(height: 16),
                  BuildMenuItem(
                    text: AppLocalizations.of(context).updates,
                    icon: Icons.update,
                    color: Colors.white,
                    onTap: () => selectedItem(context, 2),
                  ),
                  SizedBox(height: 24),
                  Divider(
                    color: Colors.white70,
                  ),
                  SizedBox(height: 24),
                  BuildMenuItem(
                    text: AppLocalizations.of(context).softwareInformation,
                    icon: Icons.info,
                    color: Colors.white,
                    onTap: () => selectedItem(context, 3),
                  ),
                  SizedBox(height: 16),
                  BuildMenuItem(
                    text: AppLocalizations.of(context).settings,
                    icon: Icons.settings,
                    color: Colors.white,
                    onTap: () => selectedItem(context, 4),
                  ),
                  SizedBox(height: 16),
                  BuildMenuItem(
                    text: AppLocalizations.of(context).helpCenter,
                    icon: Icons.help_outline_outlined,
                    color: Colors.white,
                    onTap: () => selectedItem(context, 5),
                  ),
                  SizedBox(height: 16),
                  BuildMenuItem(
                    text: AppLocalizations.of(context).policyAndTerms,
                    icon: Icons.policy,
                    color: Colors.white,
                    onTap: () => selectedItem(context, 6),
                  ),
                  SizedBox(height: 16),
                  BuildMenuItem(
                    text: AppLocalizations.of(context).logout,
                    icon: Icons.logout,
                    color: Colors.white,
                    onTap: () => selectedItem(context, 7),
                  ),
                  SizedBox(height: 28),
                  Text(
                    "© 2020 Existing Code Edu.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pop();
        break;
      case 1:
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ToDoPage()));
        break;
      case 2:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(UpdateScreen.routeName);
        break;
      case 3:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(SoftwareInformation.routeName);
        break;
      case 4:
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingScreen(
          urlImage: widget.urlImage,
          name: widget.nameUser,
          email: widget.emailUser,
          uid: widget.uid,
        )));
        break;
      case 5:
        Navigator.of(context).pop();
        launchChat();
        break;
      case 6:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(PolicyScreen.routeName);
        break;
      case 7:
        Navigator.of(context).pop();
        if(isoffline == false) {
          if(AuthBlocFacebook().fb.isLoggedIn != null) {
            logoutFacebook();
          }
          if(AuthGoogleBloc().googleSignin.isSignedIn() != null) {
            logoutGoogle();
          }
        } else {
          displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
        }
        break;
    }
  }

  void logoutFacebook() {
    var authBloc = Provider.of<AuthBlocFacebook>(context,listen: false);
    authBloc.logout();
    homeStateFacebook = authBloc.currentUser.listen((fbUser) { 
      if (fbUser == null){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginScreen(
          isDarkMode: isDarkMode,
        )), (route) => false);
        displayToastMessage(context, "Bạn đăng xuất facebook");
      }
    });
  }

  void logoutGoogle() {
    var authBlocGoogle = Provider.of<AuthGoogleBloc>(context, listen: false);
    authBlocGoogle.logout();
    homeStateGoogle = authBlocGoogle.currentUser.listen((googleUser) {
      if (googleUser == null) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginScreen(
          isDarkMode: isDarkMode,
        )), (route) => false);
        displayToastMessage(context, "Bạn đăng xuất google");
      }
    });
  }

  void launchChat() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog(
          message: "Đang tìm kiếm người hỗ trợ bạn",
        );
      }
    );

    try {
      dynamic conversationObject = {
          'appId': '3bd1adb2e63cea55e5a62d833cb0ab6e1'
      };
      final result = await KommunicateFlutterPlugin.buildConversation(conversationObject);
      print("Conversation builder success : " + result.toString());
    } on Exception catch (e) {
      print("Conversation builder error occurred : " + e.toString());
    }
  }
}