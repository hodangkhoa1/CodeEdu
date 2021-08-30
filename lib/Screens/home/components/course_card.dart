import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardCourse extends StatelessWidget {
  final String image;
  final String nameCourse;
  final int numCourses;
  final Function onTap;

  const CardCourse({
    Key key,
    @required this.image,
    @required this.nameCourse,
    @required this.numCourses,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    return Container(
      height: 272,
      width: 180,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDarkMode ? Colors.blue : Colors.transparent
        ),
        color: isDarkMode ? Color(0xFF181818) : Colors.grey[200],
      ),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.only(top: 0, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue, width: 1),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.fitHeight,
                  ),
                  color: isDarkMode ? Color(0xFF181818) : Colors.white,
                )
              ),
            )
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              nameCourse,
              style: TextStyle(
                fontSize: 18,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "${numCourses} lessons",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange
                    )
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.only(bottom: 7),
                    width: 28,
                    height: 28,
                    child: SvgPicture.asset("assets/icons/Heart Icon_2.svg"),
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}