import 'package:code_edu/Screens/profile/components/body.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String urlImage;
  final String nameUser;
  final String nameUniversity;
  final String emailUser;
  final String phoneNumber;
  final DateTime dateOfBirth;

  const ProfileScreen({
    Key key,
    @required this.urlImage,
    @required this.nameUser,
    @required this.nameUniversity,
    @required this.emailUser,
    @required this.phoneNumber,
    @required this.dateOfBirth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
          preferredSize: Size.fromHeight(1.0)
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 22
          ),
        ),
      ),
      body: Body(
        urlImage: urlImage,
        nameUser: nameUser,
        nameUniversity: nameUniversity,
        emailUser: emailUser,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
      ),
    );
  }
}