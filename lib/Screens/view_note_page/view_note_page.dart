import 'package:code_edu/Screens/view_note_page/components/body.dart';
import 'package:flutter/material.dart';

class ViewNotePage extends StatelessWidget {
  final String title;
  final String description;

  const ViewNotePage({
    Key key,
    @required this.title,
    @required this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        title: title,
        description: description,
      ),
    );
  }
}