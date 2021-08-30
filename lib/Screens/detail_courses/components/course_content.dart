import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class CourseContent extends StatefulWidget {
  final String number;
  final int hours;
  final int minutes;
  final int seconds;
  final String title;
  final bool isDone;
  final Function onTap;
  
  const CourseContent({
    Key key,
    this.number,
    this.hours,
    this.minutes,
    this.seconds,
    this.title,
    this.isDone,
    this.onTap,
  }) : super(key: key);

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    return GestureDetector(
      onTap: widget.isDone ? widget.onTap : (){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: contentBox(context),
            );
          }
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 30, left: 25, right: 25),
        child: Row(
          children: <Widget>[
            Text(
              widget.number,
              style: TextStyle(
                fontSize: 32,
                color: isDarkMode ? Colors.greenAccent : Color(0xFF0D1333).withOpacity(.15),
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    child: Text(
                      widget.seconds < 10 ? "${widget.hours}:${widget.minutes}:0${widget.seconds}\n" : "${widget.hours}:${widget.minutes}:${widget.seconds}\n",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Color(0xFF0D1333).withOpacity(.5),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 17.5,
                      color: isDarkMode ? Colors.grey : Color(0xFF0D1333),
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF49CC96).withOpacity(widget.isDone ? 1 : .5),
              ),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  contentBox(context){
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 20,
            top: 65,
            right: 20,
            bottom: 20
          ),
          margin: EdgeInsets.only(
            top: 45
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: isDarkMode ? Color(0xFF181818) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0,10),
                blurRadius: 10
              ),
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Warning",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 15,),
              Text(
                "You need to press the Enroll Now\nbutton to start the lesson.",
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.3,
                  height: 1.6
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                // ignore: deprecated_member_use
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: Image.asset("assets/images/caution.png")
              ),
            ),
        ),
      ],
    );
  }
}