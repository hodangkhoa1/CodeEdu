import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Body extends StatefulWidget {
  final String urlImage;
  final String nameUser;
  final String nameUniversity;
  final String emailUser;
  final String phoneNumber;
  final DateTime dateOfBirth;

  const Body({
    Key key,
    @required this.urlImage,
    @required this.nameUser,
    @required this.nameUniversity,
    @required this.emailUser,
    @required this.phoneNumber,
    @required this.dateOfBirth
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 115,
                  width: 115,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.urlImage),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 37,
                top: 55,
                right: 15
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.user,
                      ),
                      SizedBox(width: 15),
                      Flexible(
                        child: Text(
                          widget.nameUser,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range_outlined,
                      ),
                      SizedBox(width: 15),
                      Flexible(
                        child: Text(
                          widget.dateOfBirth != null ? widget.dateOfBirth.toString() : ((DateTime.now().day < 9 || DateTime.now().month < 9) ? "0${DateTime.now().day} / 0${DateTime.now().month} / ${DateTime.now().year}" : "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}"),
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.phone
                      ),
                      SizedBox(width: 15),
                      Flexible(
                        child: Text(
                          widget.phoneNumber,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                      ),
                      SizedBox(width: 15),
                      Flexible(
                        child: Text(
                          widget.emailUser,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.university,
                      ),
                      SizedBox(width: 15),
                      Flexible(
                        child: Text(
                          widget.nameUniversity != "" ? widget.nameUniversity : "Chưa có",
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.mapMarkerAlt
                      ),
                      SizedBox(width: 15),
                      Flexible(
                        child: Text(
                          "Việt Nam",
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}