import 'package:code_edu/Screens/note_page/components/body.dart';
import 'package:code_edu/Screens/side_bar/side_bar.dart';
import 'package:flutter/material.dart';

class CodeAppScreen extends StatefulWidget {
  final String urlImage;
  final String nameUser;
  final String nameUniversity;
  final String emailUser;
  final String phoneNumber;
  final String uid;
  final DateTime dateOfBirth;

  const CodeAppScreen({
    Key key,
    @required this.urlImage,
    @required this.nameUser,
    @required this.nameUniversity,
    @required this.emailUser,
    @required this.phoneNumber,
    @required this.uid,
    @required this.dateOfBirth,
  }) : super(key: key);

  @override
  _CodeAppScreenState createState() => _CodeAppScreenState();
}

class _CodeAppScreenState extends State<CodeAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(
        urlImage: widget.urlImage,
        nameUser: widget.nameUser,
        nameUniversity: widget.nameUniversity,
        emailUser: widget.emailUser,
        phoneNumber: widget.phoneNumber,
        uid: widget.uid,
        dateOfBirth: widget.dateOfBirth,
      ),
      body: Body(
        urlImage: widget.urlImage,
      ),
    );
  }
}