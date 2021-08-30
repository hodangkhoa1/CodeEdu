import 'package:code_edu/Screens/detail_courses/components/best_courses_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatefulWidget {
  final bool innerBoxIsScrolled;
  final Size size;
  final bool isDarkMode;

  const CustomAppBar({
    Key key,
    @required this.innerBoxIsScrolled,
    @required this.size,
    @required this.isDarkMode,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 2.5,
      shadowColor: Colors.grey[50],
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      snap: true,
      forceElevated: widget.innerBoxIsScrolled,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: SizedBox(
              height: widget.size.width * 0.1,
              width: widget.size.width * 0.1,
              // ignore: deprecated_member_use
              child: FlatButton(
                padding: EdgeInsets.only(left: 8),
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
                color: widget.isDarkMode ? Color(0xFF313131) : Colors.white,
                child: Icon(
                  Icons.arrow_back_ios
                ),
              ),
            ),
          ),
          ClipPath(
            clipper: BestCoursesClipper(),
            child: Container(
              color: Color(0xFFFFD073),
              padding: EdgeInsets.only(left: 10, top: 5, right: 20, bottom: 5),
              child: Text(
                "New Course".toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {

              });
            },
            child: Padding(
              padding: EdgeInsets.only(right: 6),
              child: SvgPicture.asset(
                "assets/icons/more-vertical.svg",
                color: Colors.grey,
              )
            ),
          ),
        ],
      ),
    );
  }
}