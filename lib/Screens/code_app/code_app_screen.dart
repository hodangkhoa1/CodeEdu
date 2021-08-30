import 'package:code_edu/Screens/code_app/components/body.dart';
import 'package:code_edu/Screens/side_bar/side_bar.dart';
import 'package:flutter/material.dart';

class CodeAppScreen extends StatefulWidget {
  final String urlImage;

  const CodeAppScreen({
    Key key,
    @required this.urlImage,
  }) : super(key: key);

  @override
  _CodeAppScreenState createState() => _CodeAppScreenState();
}

class _CodeAppScreenState extends State<CodeAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      body: Body(
        urlImage: widget.urlImage,
      ),
    );
  }
}