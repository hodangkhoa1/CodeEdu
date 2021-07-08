import 'package:code_edu/Screens/Splash/splash_screen.dart';
import 'package:code_edu/Screens/detail_courses/detail_courses_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  DetailCoursesScreen.routeName: (context) => DetailCoursesScreen(),
};