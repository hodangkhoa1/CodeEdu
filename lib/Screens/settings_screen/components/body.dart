import 'package:alan_voice/alan_voice.dart';
import 'package:code_edu/Screens/settings_screen/components/change_password.dart';
import 'package:code_edu/Screens/settings_screen/components/edit_profile.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/Screens/settings_screen/components/icon_widget.dart';
import 'package:code_edu/Screens/settings_screen/components/notifications_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:wiredash/wiredash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  final String urlImage;
  final String name;
  final String email;
  final String uid;
  static const keyVirtualAssistant = 'key-virtual-assistant';

  const Body({
    Key key,
    @required this.urlImage,
    @required this.name,
    @required this.email,
    @required this.uid
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final isVirtualAssistant = Settings.getValue<bool>(Body.keyVirtualAssistant, false);

  @override
  void initState() {
    isVirtualAssistant ? setupAlan() : removeAlan();
    super.initState();
  }

  setupAlan() {
    AlanVoice.addButton(
      "abb2dc3cb0f142707fc0244717fba2182e956eca572e1d8b807a3e2338fdd0dc/stage",
      buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT
    );
  }

  removeAlan() {
    AlanVoice.removeButton();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(24),
            children: [
              HeaderPage(
                urlImage: widget.urlImage,
                name: widget.name,
                email: widget.email,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  AppLocalizations.of(context).accountText.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              Container(
                width: double.infinity,
                height: 60,
                child: InkWell(
                  onTap: (){
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditProfile(
                          urlImage: widget.urlImage,
                          uid: widget.uid,
                        )
                      ));
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17),
                    child: Row(
                      children: [
                        IconWidget(
                          icon: Icons.person,
                          color: Colors.green,
                        ),
                        SizedBox(width: 20),
                        Text(
                          AppLocalizations.of(context).editProfile,
                          style: TextStyle(
                            fontSize: 17
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                child: InkWell(
                  onTap: (){
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangePassword()
                      ));
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17),
                    child: Row(
                      children: [
                        IconWidget(
                          icon: Icons.lock,
                          color: Colors.green,
                        ),
                        SizedBox(width: 20),
                        Text(
                          AppLocalizations.of(context).changePassword,
                          style: TextStyle(
                            fontSize: 17
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  AppLocalizations.of(context).settings.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              Container(
                width: double.infinity,
                height: 60,
                child: InkWell(
                  onTap: (){
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NotificationsPage()
                      ));
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17),
                    child: Row(
                      children: [
                        IconWidget(
                          icon: Icons.notifications,
                          color: Colors.redAccent,
                        ),
                        SizedBox(width: 20),
                        Text(
                          AppLocalizations.of(context).notifications,
                          style: TextStyle(
                            fontSize: 17
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SwitchSettingsTile(
                title: "Virtual Assistant",
                leading: IconWidget(
                  icon: Icons.accessibility,
                  color: Color(0xFF642ef3)
                ),
                settingKey: Body.keyVirtualAssistant,
                onChange: (_){},
              ),
              const SizedBox(height: 35),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 1
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context).deleteAccount,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                color: Colors.redAccent,
                height: 50,
              )
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: FloatingActionButton(
                onPressed: (){
                  setState(() {
                    Wiredash.of(context).setUserProperties(
                      userEmail: widget.email,
                    );
                    Wiredash.of(context).show();
                  });
                },
                child: Icon(
                  Icons.bug_report,
                  size: 30,
                  color: Colors.white,
                ),
                backgroundColor: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}