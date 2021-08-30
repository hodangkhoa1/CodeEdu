import 'dart:async';

import 'package:code_edu/Screens/questions_screen/questions_screen.dart';
import 'package:code_edu/Screens/quiz_app/components/category_details.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';

class CategoryDetailsList extends StatefulWidget {
  final Timer timer;
  final CategoryNotifier category;
  final bool isoffline;

  const CategoryDetailsList({
    Key key,
    @required this.timer,
    @required this.category,
    @required this.isoffline
  }) : super(key: key);

  @override
  _CategoryDetailsListState createState() => _CategoryDetailsListState();
}

class _CategoryDetailsListState extends State<CategoryDetailsList> {
  @override
  Widget build(BuildContext context) {
    widget.timer.cancel();
    return Container(
      height: 300,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.category.categoryList.length,
        itemBuilder: (_, index) {
          return CategoryDetails(
            onTap: (){
              if(widget.isoffline == false) {
                setState(() {
                  widget.category.currentCategory = widget.category.categoryList[index];
                  Navigator.pushNamedAndRemoveUntil(context, QuestionsScreen.routeName, (Route<dynamic> route) => false);
                });
              }
            },
            backgroundColor: Colors.white,
            borderColor: Colors.blue,
            imageUrl: widget.category.categoryList[index].images,
            textTitle: widget.category.categoryList[index].fullNameCourses,
            textDetail: "Practice questions from various chapters in ${widget.category.categoryList[index].nameCourses}",
          );
        }
      ),
    );
  }
}