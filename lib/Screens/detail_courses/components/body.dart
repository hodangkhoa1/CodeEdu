import 'package:code_edu/Screens/play_video_courses/play_video_courses.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatefulWidget {
  final CategoryNotifier category;

  const Body({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 1.80,
                child: Image.network(
                  widget.category.currentCategory.images,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(height: 15),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ...List.generate(
            //       widget.course.images.length,
            //       (index) => buildSmallPreview(index),
            //     ),
            //   ],
            // ),
            TopRoundedContainer(
              color: Colors.white,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          "${widget.category.currentCategory.fullNameCourses}" ?? "1",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 35, height: 28),
                          SvgPicture.asset("assets/icons/person.svg"),
                          SizedBox(width: 5),
                          Text("${widget.category.currentCategory.numberVisitors}K"),
                          SizedBox(width: 20),
                          SvgPicture.asset("assets/icons/Star Icon.svg"),
                          SizedBox(width: 5),
                          Text(
                            "${widget.category.currentCategory.rating}" ?? "0",
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
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
                        color: Colors.black.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      SizedBox(height: 15),
                      CourseContent(
                        number: "01",
                        duration: 5.35,
                        title: "Welcome to programming C",
                        isDone: true,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PlayVideoCourses(url: "https://youtu.be/kQ7hwLZiEA8",)));
                        },
                      ),
                      CourseContent(
                        number: "02",
                        duration: 5.35,
                        title: "Welcome to Java",
                        isDone: false,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PlayVideoCourses()));
                        },
                      ),
                      CourseContent(
                        number: "03",
                        duration: 5.35,
                        title: "Welcome to programming C",
                        isDone: false,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PlayVideoCourses()));
                        },
                      ),
                      CourseContent(
                        number: "04",
                        duration: 5.35,
                        title: "Welcome to programming C",
                        isDone: false,
                      ),
                      CourseContent(
                        number: "05",
                        duration: 5.35,
                        title: "Welcome to programming C",
                        isDone: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // GestureDetector buildSmallPreview(int index) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         selectedImage = index;
  //       });
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(right: 15),
  //       padding: EdgeInsets.all(3),
  //       height: 50,
  //       width: 50,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(
  //           color: selectedImage == index ? Colors.blue : Colors.transparent,
  //         ),
  //       ),
  //       child: Image.network(widget.course.images[index]),
  //     ),
  //   );
  // }
}

class CourseContent extends StatelessWidget {
  final String number;
  final double duration;
  final String title;
  final bool isDone;
  final Function onTap;
  
  const CourseContent({
    Key key,
    this.number,
    this.duration,
    this.title,
    this.isDone = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDone ? onTap : null,
      child: Padding(
        padding: EdgeInsets.only(bottom: 30, left: 25, right: 25),
        child: Row(
          children: <Widget>[
            Text(
              number,
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFF0D1333).withOpacity(.15),
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(width: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$duration mins\n",
                    style: TextStyle(
                      color: Color(0xFF0D1333).withOpacity(.5),
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF0D1333),
                      fontWeight: FontWeight.w600,
                      height: 1.5
                    ),
                  )
                ],
              )
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF49CC96).withOpacity(isDone ? 1 : .5),
              ),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  final Color color;
  final Widget child;
  
  const TopRoundedContainer({
    Key key,
    @required this.color,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}