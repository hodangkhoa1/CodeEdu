import 'package:code_edu/components/app_bar_note_button.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final String title;
  final String description;

  const Body({
    Key key,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isEdit = false;
  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            AppBar(
              leadingWidth: 74,
              leading: Row(
                children: [
                  SizedBox(width: 10),
                  AppBarNoteButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              actions: [
                AppBarNoteButton(
                  onPressed: (){
                    setState(() {
                      _isEdit = true;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      _isEdit == false ? "Edit" : "Delete",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  )
                ),
                SizedBox(width: 10)
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: color
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        enabled: _isEdit,
                        style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Colors.white
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: widget.title,
                          hintStyle: TextStyle(
                            fontSize: 30,
                            color: Colors.white70
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 20
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Thu, 16/09 | ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey
                            ),
                          ),
                          Text(
                            "100 characters",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 50,
                        right: 20
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            )
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextFormField(
                            enabled: true,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              height: 1.5
                            ),
                            maxLines: null,
                            decoration: InputDecoration.collapsed(
                              hintText: widget.description,
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.white70
                              )
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFF171C26),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            color = Colors.blue;
                          });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                            border: Border.all(
                              color: Colors.white,
                              width: 1
                            )
                          ),
                          child: color == Colors.blue ? Icon(
                            Icons.check
                          ) : null,
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            color = Colors.yellow;
                          });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow,
                            border: Border.all(
                              color: Colors.white,
                              width: 1
                            )
                          ),
                          child: color == Colors.yellow ? Icon(
                            Icons.check,
                            color: Colors.black,
                          ) : null,
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            color = Colors.white;
                          });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 1
                            )
                          ),
                          child: color == Colors.white ? Icon(
                            Icons.check,
                            color: Colors.black,
                          ) : null,
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            color = Colors.purple;
                          });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple,
                            border: Border.all(
                              color: Colors.white,
                              width: 1
                            )
                          ),
                          child: color == Colors.purple ? Icon(
                            Icons.check,
                            color: Colors.white,
                          ) : null,
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            color = Colors.green;
                          });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                            border: Border.all(
                              color: Colors.white,
                              width: 1
                            )
                          ),
                          child: color == Colors.green ? Icon(
                            Icons.check,
                            color: Colors.white,
                          ) : null,
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            color = Colors.orange;
                          });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                            border: Border.all(
                              color: Colors.white,
                              width: 1
                            )
                          ),
                          child: color == Colors.orange ? Icon(
                            Icons.check,
                            color: Colors.white,
                          ) : null,
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            color = Colors.black;
                          });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.white,
                              width: 1
                            )
                          ),
                          child: color == Colors.black ? Icon(
                            Icons.check,
                            color: Colors.white,
                          ) : null,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(
                        Icons.delete
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10
                        ),
                        child: Text(
                          "Delete note",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(
                        Icons.share,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10
                        ),
                        child: Text(
                          "Share",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}