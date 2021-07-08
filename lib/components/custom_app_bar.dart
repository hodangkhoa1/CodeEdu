import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String urlImage;
  final String textAppBar;
  final IconData iconAppBar;
  final Color iconColorAppBar;

  CustomAppBar({
    Key key,
    @required double height,
    @required this.urlImage,
    @required this.textAppBar,
    @required this.iconAppBar, 
    @required this.iconColorAppBar,
  }) : preferredSize = Size.fromHeight(height), super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  final Size preferredSize;
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey,
          height: 1,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
              builder: (context) => GestureDetector(
                // onTap: (){
                //   setState(() {
                //     Scaffold.of(context).openDrawer();
                //   });
                // },
                child: CircleAvatar(
                  radius: 22,
                  child: ClipOval(
                    child: Image.asset(
                      widget.urlImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
              ),
            ShaderMask(
              child: Text(
                widget.textAppBar,
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                ),
              ),
              shaderCallback: (rect) {
                return LinearGradient(
                  colors: <Color>[
                    Color(0xFF8a307f),
                    Color(0xFF79a7d3),
                    Color(0xFF6883bc),
                    Color(0xFF8a307f),
                    Color(0xFF79a7d3),
                    Color(0xFF6883bc),
                  ],
                ).createShader(rect);
              },
            ),
            Icon(
              widget.iconAppBar,
              size: 35,
              color: widget.iconColorAppBar,
            ),
          ],
      ),
      automaticallyImplyLeading: false,
    );
  }
}