import 'package:code_edu/Screens/settings_screen/components/body.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  final String urlImage;
  final String name;
  final String email;
  final String uid;

  const SettingScreen({
    Key key,
    @required this.urlImage,
    @required this.name,
    @required this.email,
    @required this.uid
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
          onPressed: (){
            setState(() {
              Navigator.pop(context);
            });
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.blue,
          ),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 20
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
        ),
      ),
      body: Body(
        urlImage: widget.urlImage,
        name: widget.name,
        email: widget.email,
        uid: widget.uid,
      ),
    );
  }
}