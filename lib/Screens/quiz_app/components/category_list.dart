import 'dart:async';

import 'package:code_edu/Screens/questions_screen/questions_screen.dart';
import 'package:code_edu/Screens/quiz_app/components/category_header_widget.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  final Timer timer;
  final CategoryNotifier category;
  final bool isoffline;

  const CategoryList({
    Key key,
    @required this.timer,
    @required this.category,
    @required this.isoffline
  }) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    widget.timer.cancel();
    return Container(
      height: 320,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: widget.category.categoryList.length < 4 ? widget.category.categoryList.length : 4,
        itemBuilder: (_, index) => CategoryHeader(
          onTap: (){
            if(widget.isoffline == false) {
              setState(() {
                widget.category.currentCategory = widget.category.categoryList[index];
                Navigator.pushNamed(context, QuestionsScreen.routeName);
              });
            }
          },
          boxColor: widget.category.categoryList[index].colorCategoryHeader[index],
          icon: widget.category.categoryList[index].iconCategoryHeader[index],
          text: widget.category.categoryList[index].nameCourses,
          size: widget.category.categoryList[index].iconSizeCategoryHeader[index],
        ),
      ),
    );
  }
}