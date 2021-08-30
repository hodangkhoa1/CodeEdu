import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final bool isDarkMode;
  final Function onTap;

  const CustomBottomNavigationBar({
    Key key,
    @required this.isDarkMode,
    @required this.onTap,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          height: 95,
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.isDarkMode ? Color(0xFF181818) : Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 1.0
              )
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 50,
                color: Color(0xFF0D1333).withOpacity(.1)
              )
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(14),
                height: 56,
                width: 80,
                decoration: BoxDecoration(
                  color: widget.isDarkMode ? Color(0xFF202020) : Color(0xFFFFEDEE),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: widget.isDarkMode ? Colors.grey : Colors.transparent
                  )
                ),
                child: SvgPicture.asset("assets/icons/shopping-bag.svg"),
              ),
              SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    alignment: Alignment.center,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: widget.isDarkMode ? Color(0xFF202020) : Color(0xFF6EBAFA),
                      border: Border.all(
                        color: widget.isDarkMode ? Colors.grey : Colors.transparent
                      )
                    ),
                    child: Text(
                      "Enroll Now",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
              ),
            ],
          )
        ),
      ],
    );
  }
}