import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class CategoryHeader extends StatelessWidget {
  final Color boxColor;
  final IconData icon;
  final String text;
  final double size;
  Function onTap;

  CategoryHeader({
    Key key,
    @required this.boxColor,
    @required this.icon,
    @required this.text,
    @required this.onTap,
    @required this.size
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
              size: size,
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