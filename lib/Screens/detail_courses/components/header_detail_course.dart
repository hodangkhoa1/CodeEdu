import 'package:flutter/material.dart';

class HeaderDetailCourse extends StatelessWidget {
  final Function onTap;
  final String titleCourse;
  final double startCourse;
  final String authorCourse;

  const HeaderDetailCourse({
    Key key,
    @required this.onTap,
    @required this.titleCourse,
    @required this.startCourse,
    @required this.authorCourse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 70, left: 30, right: 30, bottom: 30),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: onTap,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Color(0xFFFAFAFE),
                ),
              ),
              Expanded(child: Container()),
              Icon(
                Icons.info_outline,
                size: 25,
                color: Color(0xFFFAFAFE),
              )
            ],
          ),
          SizedBox(height: 30),
          Text(
            titleCourse,
            style: TextStyle(
              fontSize: 23,
              color: Color(0xFFFEFEFF)
            ),
          ),
          SizedBox(height: 50),
          Row(
            children: [
              Container(
                width: 90,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF475ADC),
                      Color(0xFF536DE2)
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star_rate_rounded,
                      size: 25,
                      color: Color(0xFFFAFAFE),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${startCourse}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFFAFAFE)
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 240,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF475ADC),
                      Color(0xFF536DE2)
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.create,
                      size: 20,
                      color: Color(0xFFFAFAFE),
                    ),
                    SizedBox(width: 5),
                    Text(
                      authorCourse,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFFAFAFE)
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}