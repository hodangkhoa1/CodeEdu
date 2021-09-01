import 'dart:async';

import 'package:code_edu/Screens/home/components/category_list.dart';
import 'package:code_edu/Screens/home/components/shimmer_list.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';

class DelayedCategoryList extends StatefulWidget {
  final CategoryNotifier categoryNotifier;
  final bool isoffline;
  final bool showBottomBar;
  final String urlAvatar;
  final bool isDarkMode;
  final String uid;

  const DelayedCategoryList({
    Key key,
    @required this.categoryNotifier,
    @required this.isoffline,
    @required this.showBottomBar,
    @required this.urlAvatar,
    @required this.isDarkMode,
    @required this.uid,
  }) : super(key: key);

  @override
  _DelayedCategoryListState createState() => _DelayedCategoryListState();
}

class _DelayedCategoryListState extends State<DelayedCategoryList> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    Timer timer = Timer(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });

    return isLoading ? ShimmerList() : CategoryList(
      timer: timer,
      categoryNotifier: widget.categoryNotifier,
      isoffline: widget.isoffline,
      showBottomBar: widget.showBottomBar,
      urlAvatar: widget.urlAvatar,
      isDarkMode: widget.isDarkMode,
      uid: widget.uid,
    );
  }
}