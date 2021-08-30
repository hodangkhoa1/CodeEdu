import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/Screens/detail_courses/components/course_content_list.dart';
import 'package:code_edu/Screens/detail_courses/components/custom_app_bar.dart';
import 'package:code_edu/Screens/detail_courses/components/custom_bottom_navigation_bar.dart';
import 'package:code_edu/Screens/detail_courses/components/top_rounded_container.dart';
import 'package:code_edu/data/category.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DetailCoursesScreen extends StatefulWidget {
  static String routeName = "/details";
  final String showBottomBar;
  final String urlAvatar;
  final bool isDarkMode;

  const DetailCoursesScreen({
    Key key,
    this.showBottomBar,
    this.urlAvatar,
    this.isDarkMode,
  }) : super(key: key);

  @override
  _DetailCoursesScreenState createState() => _DetailCoursesScreenState();
}

class _DetailCoursesScreenState extends State<DetailCoursesScreen> {
  bool showBottomBar = false;
  final db = FirebaseFirestore.instance;
  List<CoursesDetail> _courseContent = [];

  @override
  Widget build(BuildContext context) {
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    //bool showBottomBar = (String.fromEnvironment(widget.showBottomBar) == "true") ? true : (String.fromEnvironment(widget.showBottomBar) == "false") ? false : false;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CustomAppBar(
            innerBoxIsScrolled: innerBoxIsScrolled,
            size: size,
            isDarkMode: widget.isDarkMode,
          ),
        ],
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1.80,
                        child: Image.network(
                          categoryNotifier.currentCategory.images,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TopRoundedContainer(
                      color: widget.isDarkMode ? Color(0xFF313131) : Colors.white,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "${categoryNotifier.currentCategory.fullNameCourses}" ?? "1",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 35, height: 28),
                              SvgPicture.asset(
                                "assets/icons/person.svg",
                                color: widget.isDarkMode ? Colors.blue : Colors.black,
                              ),
                              SizedBox(width: 5),
                              Text("${categoryNotifier.currentCategory.numberVisitors}K"),
                              SizedBox(width: 20),
                              SvgPicture.asset("assets/icons/Star Icon.svg"),
                              SizedBox(width: 5),
                              Text(
                                "${categoryNotifier.currentCategory.rating}" ?? "0",
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "Course Content",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  width: 64,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFE6E6),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)
                                    )
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/Heart Icon_2.svg",
                                    color: Color(0xFFFF4848),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(
                            height: 30,
                            thickness: 0.5,
                            color: widget.isDarkMode ? Colors.grey : Colors.black.withOpacity(0.3),
                            indent: 32,
                            endIndent: 32,
                          ),
                          SizedBox(height: 15),
                          CourseContentList(
                            categoryNotifier: categoryNotifier,
                            courseDetail: _courseContent,
                            db: db,
                            urlAvatar: widget.urlAvatar,
                            isDarkMode: widget.isDarkMode,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: showBottomBar == false ? CustomBottomNavigationBar(
        isDarkMode: widget.isDarkMode,
        onTap: (){},
      ) : Stack(
        children: [
          Container(
            height: 0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          )
        ]
      )
    );
  }
}