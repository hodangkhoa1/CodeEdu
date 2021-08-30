import 'package:code_edu/Screens/questions_screen/components/body.dart';
import 'package:code_edu/Screens/questions_screen/components/custom_app_bar.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionsScreen extends StatelessWidget {
  static String routeName = "/questionsScreen";

  const QuestionsScreen({
    Key key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context, listen: false);

    return Scaffold(
      appBar: BuildAppBar(
        category: categoryNotifier,
        height: 60,
      ),
      body: Body(
        category: categoryNotifier,
      ),
    );
  }
}