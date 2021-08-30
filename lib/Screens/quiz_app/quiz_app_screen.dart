import 'package:code_edu/Screens/quiz_app/components/body.dart';
import 'package:code_edu/Screens/side_bar/side_bar.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizApp extends StatefulWidget {
  final String urlImage;

  const QuizApp({
    Key key,
    this.urlImage
  }) : super(key: key);

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {

  @override
  Widget build(BuildContext context) {
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context, listen: false);
    return Scaffold(
      drawer: SideBar(),
      body: Body(
        category: categoryNotifier,
        urlImage: widget.urlImage,
      ),
    );
  }
}