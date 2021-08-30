import 'dart:async';

import 'package:code_edu/Screens/quiz_app/components/category_details_list.dart';
import 'package:code_edu/Screens/quiz_app/components/shimmer_category_details.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';

class DelayedCategoryDetailsList extends StatefulWidget {
  final CategoryNotifier category;
  final bool isoffline;

  const DelayedCategoryDetailsList({
    Key key,
    @required this.category,
    @required this.isoffline
  }) : super(key: key);

  @override
  _DelayedCategoryDetailsListState createState() => _DelayedCategoryDetailsListState();
}

class _DelayedCategoryDetailsListState extends State<DelayedCategoryDetailsList> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    Timer timer = Timer(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });

    return isLoading ? ShimmerCategoryDetails() : CategoryDetailsList(
      timer: timer,
      category: widget.category,
      isoffline: widget.isoffline,
    );
  }
}