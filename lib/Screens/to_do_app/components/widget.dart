import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String desc;
  
  const TaskCardWidget({
    Key key,
    this.title,
    this.desc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 24
      ),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "(Unnamed Task)",
            style: TextStyle(
              color: Color(0xFF211551),
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              desc ?? "No description added",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF86829D),
                height: 1.5,
              ),
            ),
          )
        ],
      )
    );
  }
}

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
              Icons.check,
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

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome (BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}