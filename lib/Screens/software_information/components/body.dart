import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class Body extends StatelessWidget {
  const Body({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/icon-app.png",
                width: 80,
                height: 80,
              ),
              SizedBox(height: 25),
              Text(
                "Code Edu for Android",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Divider(
                  color: Colors.grey[850],
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SimpleSettingsTile(
                  title: "Version",
                  subtitle: '1.0',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SimpleSettingsTile(
                  title: "Creator App",
                  subtitle: 'Khoa Ho',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SimpleSettingsTile(
                  title: "License",
                  subtitle: 'Copyright © 2021 CodeEdu.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}