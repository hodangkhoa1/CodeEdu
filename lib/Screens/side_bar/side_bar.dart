import 'dart:async';

import 'package:code_edu/AllWidgets/display_toast_message.dart';
import 'package:code_edu/Screens/Login/login_screen.dart';
import 'package:code_edu/Screens/help_center/help_center.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  final String urlImage;
  final String nameGoogleLogin;
  final String emailGoogleLogin;

  const SideBar({
    Key key,
    this.urlImage,
    this.nameGoogleLogin,
    this.emailGoogleLogin,
  }) : super(key: key);
  
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
  StreamSubscription<User> homeStateFacebook;
  StreamSubscription<User> homeStateGoogle;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: isDarkMode ? Color(0xFF212121) : Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            BuildHeader(
              urlImage: widget.urlImage != null ? widget.urlImage : "https://firebasestorage.googleapis.com/v0/b/codeeduapp.appspot.com/o/21-avatar-outline.gif?alt=media&token=7b98a6a0-15c8-4fd0-9d78-2ed2d468112a",
              name: widget.nameGoogleLogin,
              email: widget.emailGoogleLogin,
              onClicked: (){
                setState(() {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      nameProfile: widget.nameGoogleLogin,
                      emailProfile: widget.emailGoogleLogin,
                      urlImage: widget.urlImage,
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
          urlImage: widget.urlImage != null ? widget.urlImage : "https://firebasestorage.googleapis.com/v0/b/codeeduapp.appspot.com/o/21-avatar-outline.gif?alt=media&token=7b98a6a0-15c8-4fd0-9d78-2ed2d468112a",
          name: widget.nameGoogleLogin,
          email: widget.emailGoogleLogin,
        )));
        break;
      case 5:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(HelpCenter.routeName);
        break;
      case 6:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(PolicyScreen.routeName);
        break;
      case 7:
        Navigator.of(context).pop();
        if(AuthBlocFacebook().fb.isLoggedIn != null) {
          logoutFacebook();
        }
        if(AuthGoogleBloc().googleSignin.isSignedIn() != null) {
          logoutGoogle();
        }
        // if(AuthService().currentUser != null) {
        //   final authService = AuthService();
        //   AuthService().logout();
        //   authService.currentUser.listen((googleUser) {
        //     if(googleUser == null) {
        //       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginScreen(
        //         isDarkMode: isDarkMode,
        //       )), (route) => false);
        //     }
        //   });
        // } else if(AuthBlocFacebook().currentUser != null) {
        //   logoutFacebook();
        // }
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
}