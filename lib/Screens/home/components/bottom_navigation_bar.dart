import 'package:flutter/material.dart';

class NavigationBarBottom extends StatefulWidget {
  final Function onTap;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final String text;
  final IconData icon;

  NavigationBarBottom({
    @required this.onTap,
    @required this.borderColor,
    @required this.text, 
    @required this.iconColor,
    @required this.textColor, 
    @required this.icon,
  });
  
  @override
  _NavigationBarBottomState createState() => _NavigationBarBottomState();
}

class _NavigationBarBottomState extends State<NavigationBarBottom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: widget.borderColor,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            children: <Widget>[
              Icon(
                widget.icon,
                color: widget.iconColor,
                size: 32,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}