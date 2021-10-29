import 'package:flutter/material.dart';

class AppBarNoteButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const AppBarNoteButton({
    Key key,
    @required this.child,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ButtonTheme(
        minWidth: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6)
        ),
        // ignore: deprecated_member_use
        child: FlatButton(
          padding: EdgeInsets.only(right: 2),
          color: Colors.grey,
          child: child,
          onPressed: onPressed,
        ),
      ),
    );
  }
}