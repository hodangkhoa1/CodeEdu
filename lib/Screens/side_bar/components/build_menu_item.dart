import 'package:flutter/material.dart';

class BuildMenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const BuildMenuItem({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.color,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorText = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 30,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: colorText,
          fontSize: 16,
          fontWeight: FontWeight.w500
        )
      ),
      hoverColor: hoverColor,
      onTap: onTap,
    );
  }
}