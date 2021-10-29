import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final List<Color> colorCategoryHeader = [
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.green
  ];
  final List<IconData> iconCategoryHeader = [
    FontAwesomeIcons.networkWired,
    FontAwesomeIcons.fileCode,
    FontAwesomeIcons.java,
    FontAwesomeIcons.database,
  ];
  final List<double> iconSizeCategoryHeader = [
    50,
    50,
    60,
    50
  ];
  String nameCourses;
  String images;
  double rating;
  int numCourses;
  String fullNameCourses;
  String courseID;
  String author;

  Category.fromMap(Map<String, dynamic> data) {
    courseID = data['courseID'];
    nameCourses = data['nameCourse'];
    images = data['images'];
    rating = data['rating'];
    numCourses = data['numCourses'];
    fullNameCourses = data['fullNameCourse'];
    author = data['author'];
  }
}

class CoursesDetail {
  int hours;
  int minutes;
  int numberCourse;
  int seconds;
  String title;
  String urlVideo;
  String urlPDF;
  String urlImage;

  CoursesDetail.fromMap(Map<String, dynamic> data) {
    hours = data['hours'];
    minutes = data['minutes'];
    numberCourse = data['numberCourse'];
    seconds = data['seconds'];
    title = data['title'];
    urlVideo = data['urlVideo'];
    urlPDF = data['urlPDF'];
    urlImage = data['urlImage'];
  }
}