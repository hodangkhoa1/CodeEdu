import 'dart:async';

import 'package:code_edu/Screens/quiz_app/components/category_list.dart';
import 'package:code_edu/Screens/quiz_app/components/shimmer_gridview_category.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';

class DelayedCategoryList extends StatefulWidget {
  final CategoryNotifier category;
  final bool isoffline;

  const DelayedCategoryList({
    Key key,
    @required this.category,
    @required this.isoffline
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

    return isLoading ? ShimmerGridViewCategory() : CategoryList(
      timer: timer,
      category: widget.category,
      isoffline: widget.isoffline,
    );
  }
}