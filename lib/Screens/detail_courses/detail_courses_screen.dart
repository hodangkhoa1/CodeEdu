import 'package:code_edu/Screens/detail_courses/components/body.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DetailCoursesScreen extends StatelessWidget {
  static String routeName = "/details";
  @override
  Widget build(BuildContext context) {
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(),
      body: Body(
        category: categoryNotifier,
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
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
                    color: Color(0xFFFFEDEE),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: SvgPicture.asset("assets/icons/shopping-bag.svg"),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color(0xFF6EBAFA),
                    ),
                    child: Text(
                      "Enroll Now",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 15, left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: SizedBox(
                height: size.width * 0.1,
                width: size.width * 0.1,
                // ignore: deprecated_member_use
                child: FlatButton(
                  padding: EdgeInsets.only(left: 8),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: Colors.white,
                  child: Icon(Icons.arrow_back_ios),
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
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: SvgPicture.asset("assets/icons/more-vertical.svg")
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BestCoursesClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
  
}
