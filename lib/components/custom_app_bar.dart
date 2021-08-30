import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final String urlImage;
  final String nameScreen;
  final Function onTap;
  final IconData iconScreen;

  const CustomAppBar({
    Key key,
    @required this.urlImage,
    @required this.nameScreen,
    @required this.onTap,
    @required this.iconScreen,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
            )
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                    bottom: 3,
                    left: 1
                  ),
                  child: CircleAvatar(
                    radius: 22,
                    child: ClipOval(
                      child: Image.network(
                        widget.urlImage != null ? widget.urlImage : "https://firebasestorage.googleapis.com/v0/b/codeeduapp.appspot.com/o/21-avatar-outline.gif?alt=media&token=7b98a6a0-15c8-4fd0-9d78-2ed2d468112a",
                        fit: BoxFit.contain,
                      )
                    ),
                  ),
                ),
              ),
              Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.nameScreen,
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.grey
                  ),
                ),
              )
            ),
              // Expanded(
              //   child: ShaderMask(
              //     child: Align(
              //       alignment: Alignment.center,
              //       child: Text(
              //         widget.nameScreen,
              //         style: TextStyle(
              //           fontSize: 23,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //     shaderCallback: (rect) {
              //       return LinearGradient(
              //         colors: <Color>[
              //           Color(0xFF8a307f),
              //           Color(0xFF79a7d3),
              //           Color(0xFF6883bc),
              //           Color(0xFF8a307f),
              //           Color(0xFF79a7d3),
              //           Color(0xFF6883bc),
              //         ],
              //       ).createShader(rect);
              //     },
              //   ),
              // ),
              GestureDetector(
                onTap: widget.onTap,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 3,
                    right: 1
                  ),
                  child: Icon(
                    widget.iconScreen,
                    size: 35,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}