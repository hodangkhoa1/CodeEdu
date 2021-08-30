import 'dart:async';

import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// ignore: must_be_immutable
class SwiperImage extends StatefulWidget {
  int current;
  final CategoryNotifier categoryNotifier;
  final Timer timer;
  final Function map;

  SwiperImage({
    Key key,
    @required this.current,
    @required this.categoryNotifier,
    @required this.timer,
    @required this.map,
  }) : super(key: key);

  @override
  _SwiperImageState createState() => _SwiperImageState();
}

class _SwiperImageState extends State<SwiperImage> {
  @override
  Widget build(BuildContext context) {
    widget.timer.cancel();
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 233,
          child: Swiper(
            onIndexChanged: (index) {
              setState(() {
                widget.current = index;
              });
            },
            autoplay: true,
            layout: SwiperLayout.DEFAULT,
            itemCount: widget.categoryNotifier.categoryList.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(widget.categoryNotifier.categoryList[index].images),
                    fit: BoxFit.fitHeight
                  )
                ),
              );
            },
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: widget.map<Widget>(
                widget.categoryNotifier.categoryList,
                (index, image) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    height: 6,
                    width: 6,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.current == index ? Color(0xFF2C53B1) : Color(0xFFB4B0B0)
                    ),
                  );
                }
              ),
            ),
            Text(
              "More...",
              style: TextStyle(
                color: Colors.blue
              ),
            )
          ],
        ),
      ],
    );
  }
}