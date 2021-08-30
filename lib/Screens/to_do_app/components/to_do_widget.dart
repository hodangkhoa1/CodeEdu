import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  final String text;
  final bool isDone;

  const TodoWidget({
    Key key,
    this.text,
    @required this.isDone
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: isDone ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: isDone ? null : Border.all(
                color: Color(0xFF86829D),
                width: 1.5
              )
            ),
            child: Icon(
              isDone ? Icons.check : null,
              color: Colors.white,
            )
          ),
          Text(
            text ?? "(Unnamed Todo)",
            style: TextStyle(
              color: isDone ? Colors.blue : Color(0xFF86829D),
              fontSize: 16,
              fontWeight: isDone ? FontWeight.bold : FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}