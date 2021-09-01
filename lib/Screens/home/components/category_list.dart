import 'dart:async';

import 'package:code_edu/Screens/detail_courses/detail_courses_screen.dart';
import 'package:code_edu/Screens/home/components/course_card.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryList extends StatefulWidget {
  final CategoryNotifier categoryNotifier;
  final bool isoffline;
  final Timer timer;
  final bool showBottomBar;
  final String urlAvatar;
  final bool isDarkMode;
  final String uid;

  const CategoryList({
    Key key,
    @required this.categoryNotifier,
    @required this.timer,
    @required this.isoffline,
    @required this.showBottomBar,
    @required this.urlAvatar,
    @required this.isDarkMode,
    @required this.uid,
  }) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    widget.timer.cancel();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            itemCount: widget.categoryNotifier.categoryList.length,
            crossAxisSpacing: 10,
            mainAxisSpacing: 1,
            itemBuilder: (context, index) {
              return CardCourse(
                image: widget.categoryNotifier.categoryList[index].images,
                nameCourse: widget.categoryNotifier.categoryList[index].nameCourses,
                numCourses: widget.categoryNotifier.categoryList[index].numCourses,
                onTap: (){
                  if(widget.isoffline == false) {
                    setState(() {
                      widget.categoryNotifier.currentCategory = widget.categoryNotifier.categoryList[index];
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                        return DetailCoursesScreen(
                          showBottomBar: widget.showBottomBar,
                          urlAvatar: widget.urlAvatar,
                          isDarkMode: widget.isDarkMode,
                          uid: widget.uid,
                        );
                      }));
                    });
                  }
                },
              );
            },
            staggeredTileBuilder: (index) {
              return new StaggeredTile.count(1, index.isEven ? 1.618 : 1.618);
            }
          ),
        ],
      ),
    );
  }
}