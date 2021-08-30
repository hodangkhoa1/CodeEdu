import 'dart:async';

import 'package:code_edu/Screens/home/components/shimmer_swiper.dart';
import 'package:code_edu/Screens/home/components/swiper_image.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';

class DelayedSwiperImage extends StatefulWidget {
  final int current;
  final CategoryNotifier categoryNotifier;
  final Function map;
  
  const DelayedSwiperImage({
    Key key,
    @required this.current,
    @required this.categoryNotifier,
    @required this.map
  }) : super(key: key);

  @override
  _DelayedSwiperImageState createState() => _DelayedSwiperImageState();
}

class _DelayedSwiperImageState extends State<DelayedSwiperImage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    Timer timer = Timer(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    return isLoading ? ShimmerSwiper() : SwiperImage(
      timer: timer,
      current: widget.current,
      categoryNotifier: widget.categoryNotifier,
      map: widget.map,
    );
  }
}