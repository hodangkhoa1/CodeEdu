import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildCardItem extends StatelessWidget {
  final String urlImage;
  final String nameCourse;
  //final int numberView;
  final double numberRating;
  final String urlAvatar;

  const BuildCardItem({
    Key key,
    @required this.urlImage,
    @required this.nameCourse,
    //@required this.numberView,
    @required this.numberRating,
    @required this.urlAvatar
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    return Container(
      padding: EdgeInsets.all(12),
      height: 250,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(
                  color: Colors.grey,
                  width: 1
                ),
                image: DecorationImage(
                  image: NetworkImage(urlImage),
                  fit: BoxFit.cover
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 1,
                    color: Colors.grey
                  )
                ]
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * .43,
              height: 200,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode ? Color(0xFF4D4D4D) : Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 1,
                    color: Colors.grey
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 1,
                  left: 1
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameCourse,
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/person.svg",
                              color: isDarkMode ? Colors.blue : Colors.black,
                            ),
                            SizedBox(width: 5),
                            // Text(
                            //   "${numberView} views",
                            //   style: TextStyle(
                            //     fontSize: 13
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 5),
                        RatingBar.builder(
                          onRatingUpdate: (v) {},
                          initialRating: numberRating,
                          itemSize: 16,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "233 thuật ngữ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 28
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(urlAvatar)
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50)
                              )
                            ),
                          ),
                          SizedBox(width: 7),
                          Text(
                            "Hồ Đăng Khoa",
                            style: TextStyle(
                              fontSize: 16
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}