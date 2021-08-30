import 'package:code_edu/Screens/profile/components/body.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String nameProfile;
  final String emailProfile;
  final String urlImage;

  const ProfileScreen({
    Key key,
    @required this.nameProfile,
    @required this.emailProfile,
    @required this.urlImage,
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
        nameProfile: nameProfile,
        emailProfile: emailProfile,
        urlImage: urlImage,
      ),
    );
  }
}