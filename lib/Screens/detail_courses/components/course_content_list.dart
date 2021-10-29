import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/Screens/detail_courses/components/show_dialog_choose_options.dart';
import 'package:code_edu/data/category.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CourseContentList extends StatefulWidget {
  final List<CoursesDetail> courseDetail;
  final bool isDarkMode;
  final bool isDone;
  final String urlAvatar;
  final List<QueryDocumentSnapshot<Object>> doc;

  const CourseContentList({
    Key key,
    @required this.courseDetail,
    @required this.isDarkMode,
    @required this.isDone,
    @required this.doc,
    @required this.urlAvatar,
  }) : super(key: key);

  @override
  _CourseContentListState createState() => _CourseContentListState();
}

class _CourseContentListState extends State<CourseContentList> with TickerProviderStateMixin {
  AnimationController _notFoundController;

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  @override
  void initState() {
    _notFoundController = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _notFoundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.courseDetail.isNotEmpty ? ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          shrinkWrap: true,
          itemCount: widget.doc.length,
          itemBuilder: (_, int index) {
            return GestureDetector(
              onTap: widget.isDone ? () {
                setState(() {
                  showDialogChooseOptions(
                    context,
                    widget.courseDetail[index].urlVideo,
                    widget.courseDetail[index].urlPDF,
                    widget.urlAvatar,
                    widget.courseDetail[index].title,
                    widget.isDarkMode
                  );
                });
              } : () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: contentBox(context, widget.isDone),
                    );
                  }
                );
              },
              child: Container(
                height: 145,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey
                          ),
                          child: Center(
                            child: widget.courseDetail[index].urlImage.isEmpty ? Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold
                              ),
                            ) : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                                image: NetworkImage(
                                  widget.courseDetail[index].urlImage,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  widget.courseDetail[index].title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: widget.isDarkMode ? Colors.white : Color(0xFF0D1333),
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "${widget.courseDetail[index].hours}:${convertTwo(widget.courseDetail[index].minutes)}:${convertTwo(widget.courseDetail[index].seconds)}",
                                  style: TextStyle(
                                    color: widget.isDarkMode ? Colors.grey : Color(0xFF0D1333).withOpacity(.5),
                                  ),
                                ),
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
                    SizedBox(height: 18),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Color(0xFFEAEEFC),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text(
                              "15s rest",
                              style: TextStyle(
                                color: Color(0xFF839FED)
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            for (var i = 0; i < 70; i++)
                            i.isEven ? Container(
                              width: 3,
                              height: 1,
                              decoration: BoxDecoration(
                                color: Color(0xFF839FED),
                                borderRadius: BorderRadius.circular(2)
                              ),
                            ) : Container(
                              width: 3,
                              height: 1,
                              color: Colors.white,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        ) : Lottie.asset(
          "assets/images/38061-search.json",
          height: MediaQuery.of(context).size.height * 0.30,
          controller: _notFoundController,
          onLoaded: (animation) {
            _notFoundController..duration = animation.duration..repeat(
              reverse: true
            );
          },
        )
      ],
    );
  }

  contentBox(context, isDarkMode){
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