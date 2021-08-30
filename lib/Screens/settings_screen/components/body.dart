import 'package:code_edu/Screens/settings_screen/components/change_password.dart';
import 'package:code_edu/Screens/settings_screen/components/edit_profile.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/Screens/settings_screen/components/icon_widget.dart';
import 'package:code_edu/Screens/settings_screen/components/motifications_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';

class Body extends StatefulWidget {
  final String urlImage;
  final String name;
  final String email;

  const Body({
    Key key,
    @required this.urlImage,
    @required this.name,
    @required this.email,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
                  "ACCOUNT",
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
                        builder: (context) => EditProfile()
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
                          "Edit Profile",
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
                          "Change Password",
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
                  "SETTINGS",
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
                          "Notifications",
                          style: TextStyle(
                            fontSize: 17
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // SettingsGroup(
              //   title: "General",
              //   children: [
              //     const SizedBox(height: 10),
              //     AccountPage(),
              //     const SizedBox(height: 10),
              //     NotificationsPage(),
              //   ]
              // ),
              // const SizedBox(height: 20),
              // SettingsGroup(
              //   title: "Feedback",
              //   children: [
              //     const SizedBox(height: 10),
              //     SimpleSettingsTile(
              //       title: "Report a bug",
              //       subtitle: '',
              //       leading: IconWidget(
              //         color: Colors.teal,
              //         icon: Icons.bug_report
              //       ),
              //       onTap: (){},
              //     ),
              //     const SizedBox(height: 10),
              //     SimpleSettingsTile(
              //       title: "Send Feedback",
              //       subtitle: '',
              //       leading: IconWidget(
              //         color: Colors.purple,
              //         icon: Icons.thumb_up,
              //       ),
              //       onTap: (){},
              //     )
              //   ]
              // ),
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
                        "Delete Account",
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