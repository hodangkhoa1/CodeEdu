import 'package:code_edu/Screens/settings_screen/components/body.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    Key key
  }) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.blue,
          ),
        ),
      ),
      body: Body(),
    );
  }
}