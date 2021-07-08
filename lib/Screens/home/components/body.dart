import 'package:code_edu/Screens/detail_courses/detail_courses_screen.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:code_edu/requestAPI/category_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

String getTimeNow() {
  var timeNow = DateTime.now().hour;

  if (timeNow <= 12) {
    return 'Good Morning';
  } else if ((timeNow > 12) && (timeNow <= 16)) {
    return 'Good Afternoon';
  } else if ((timeNow > 16) && (timeNow < 20)) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context, listen: false);
    getCategory(categoryNotifier);
    super.initState();    
  }

  String greetingMes = getTimeNow();
  
  @override
  Widget build(BuildContext context) {
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context);
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 105, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              greetingMes,
              style: TextStyle(
                fontSize: 28,
                color: Color(0xFF0D1333),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Find a course you want to learn",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF61688B),
                height: 2,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.circular(40)),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/search.svg"),
                  SizedBox(width: 20),
                  Flexible(
                      child: TextFormField(
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        hintText: "Search for anything",
                        border: InputBorder.none),
                  )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Category",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF0D1333),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 35), //30
            //CourseCard(),
            Expanded(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: categoryNotifier.categoryList.length,
                crossAxisSpacing: 10,
                mainAxisSpacing: 1,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              categoryNotifier.currentCategory = categoryNotifier.categoryList[index];
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context){
                                  return DetailCoursesScreen();
                                })
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 0, bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blue, width: 1),
                                image: DecorationImage(
                                  image: NetworkImage(categoryNotifier.categoryList[index].images),
                                  fit: BoxFit.contain,
                                ),
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            categoryNotifier.currentCategory = categoryNotifier.categoryList[index];
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context){
                                return DetailCoursesScreen();
                              })
                            );
                          },
                          child: Text(
                            categoryNotifier.categoryList[index].nameCourses,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text(
                                  "${categoryNotifier.categoryList[index].numCourses} lessons",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 7),
                                  width: 28,
                                  height: 28,
                                  child: SvgPicture.asset("assets/icons/Heart Icon_2.svg"),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                staggeredTileBuilder: (index) {
                  return new StaggeredTile.count(1, index.isEven ? 1.618 : 1.618);
                }
              ),
            ),
            SizedBox(height: 118)
          ],
        ),
      ),
    );
  }
}