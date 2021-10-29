import 'dart:math';

import 'package:code_edu/model/note_model.dart';
import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final NoteModel noteModel;
  final Function onTap;
  
  const NoteTile({
    Key key,
    @required this.noteModel,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = [
      Colors.pink.shade200,
      Colors.blue.shade200,
      Color(0xFFFF33FF),
      Colors.brown,
      Colors.cyan,
      Colors.deepPurple,
      Colors.greenAccent,
      Colors.tealAccent
    ];

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors[Random().nextInt(5)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              noteModel.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
            Text(noteModel.description),
            SizedBox(height: 5),
            Text(
              "${noteModel.createdat.day}/${noteModel.createdat.month}/${noteModel.createdat.year}"
            )
          ],
        ),
      ),
    );
  }
}