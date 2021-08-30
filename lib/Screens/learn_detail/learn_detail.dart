import 'package:code_edu/Screens/learn_detail/components/body.dart';
import 'package:flutter/material.dart';

class LearnDetail extends StatefulWidget {
  final String nameText;
  final String courseID;

  const LearnDetail({
    Key key,
    @required this.nameText,
    @required this.courseID,
  }) : super(key: key);

  @override
  _LearnDetailState createState() => _LearnDetailState();
}

class _LearnDetailState extends State<LearnDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: (){
            setState(() {
              Navigator.pop(context);
            });
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.blue,
          ),
        ),
        title: Text(
          widget.nameText,
          style: TextStyle(
            fontSize: 20
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
        ),
      ),
      body: Body(
        courseID: widget.courseID,
      ),
    );
  }
}