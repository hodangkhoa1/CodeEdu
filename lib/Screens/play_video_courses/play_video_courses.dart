import 'package:code_edu/Screens/play_video_courses/components/body.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlayVideoCourses extends StatelessWidget {
  final String url;
  final String nameLesson;
  final String urlAvatar;

  const PlayVideoCourses({
    Key key,
    @required this.url,
    @required this.nameLesson,
    @required this.urlAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);

    return Scaffold(
      body: Body(
        isDarkMode: isDarkMode,
        url: url,
        nameLesson: nameLesson,
        urlAvatar: urlAvatar,
      ),
    );
  }
}