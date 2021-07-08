import 'package:code_edu/Screens/play_video_courses/components/body.dart';
import 'package:flutter/material.dart';

class PlayVideoCourses extends StatefulWidget {
  final url;

  const PlayVideoCourses({
    Key key,
    @required this.url,
  }) : super(key: key);

  @override
  _PlayVideoCoursesState createState() => _PlayVideoCoursesState();
}

class _PlayVideoCoursesState extends State<PlayVideoCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: (){
            setState(() {
              Navigator.pop(context);
            });
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.blue,
          ),
        ),
        title: Text(
          "Lesson 1",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
      body: Body(
        url: widget.url,
      ),
    );
  }
}