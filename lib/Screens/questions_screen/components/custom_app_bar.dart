import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget{
  final CategoryNotifier category;

  @override
  final Size preferredSize;

  BuildAppBar({
    @required double height,
    Key key,
    @required this.category,
  }) : preferredSize = Size.fromHeight(height), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Align(
        alignment: Alignment.center,
        child: Text(
          category.currentCategory.fullNameCourses,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepOrange,
              Colors.purple
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft
          )
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.shade300,
          height: 1,
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }
}