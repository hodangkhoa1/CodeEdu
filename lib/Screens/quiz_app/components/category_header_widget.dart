import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryHeader extends StatelessWidget {
  final Color boxColor;
  final IconData icon;
  final String text;
  Function onTap;

  CategoryHeader({
    Key key,
    @required this.boxColor,
    @required this.icon,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              color: Colors.white,
              size: 50,
            ),
            SizedBox(height: 12),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 19
              ),
            )
          ],
        ),
      ),
    );
  }
}