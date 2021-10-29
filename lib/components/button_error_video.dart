import 'package:flutter/material.dart';

class ButtonErrorVideo extends StatelessWidget {
  final String text;
  final Function onPressed;

  const ButtonErrorVideo({
    Key key,
    @required this.text,
    @required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF604FEF),
            Color(0xFFA74DBC)
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.symmetric(vertical: 12),
      height: 45,
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}