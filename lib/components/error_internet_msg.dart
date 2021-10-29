import 'package:flutter/material.dart';

class ErrorMsg extends StatelessWidget {
  final String text;
  final bool show;

  const ErrorMsg({
    Key key,
    @required this.text,
    @required this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(show == true) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 10),
        color: Colors.red,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 6),
              child: Icon(
                Icons.info,
                color: Colors.white,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}