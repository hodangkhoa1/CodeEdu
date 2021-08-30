import 'package:code_edu/Screens/play_video_courses/components/body.dart';
import 'package:flutter/material.dart';

class PlayVideoCourses extends StatefulWidget {
  final url;
  final String urlAvatar;
  final String nameLesson;

  const PlayVideoCourses({
    Key key,
    @required this.url,
    @required this.urlAvatar,
    @required this.nameLesson,
  }) : super(key: key);

  @override
  _PlayVideoCoursesState createState() => _PlayVideoCoursesState();
}

class _PlayVideoCoursesState extends State<PlayVideoCourses> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      // ignore: missing_return
      builder: (context, orientation) {
        switch(orientation) {
          case Orientation.portrait:
            return Scaffold(
              body: Body(
                url: widget.url,
                urlAvatar: widget.urlAvatar,
                nameLesson: widget.nameLesson,
              ),
            );
            break;
            case Orientation.landscape:
              return Scaffold(
                body: Body(
                  url: widget.url,
                ),
              );
            break;
        }
      }
    );
  }
}