import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBarHomeCustom extends StatefulWidget {
  final String urlAvatar;
  final bool folded;
  final String nameTextAppBar;
  final bool isDarkMode;
  final AnimationController animationController;
  final double angle;
  final Function onTap;
  final TextEditingController textEditingController;
  final Function onTapTextField;
  final Function onPressed;

  const AppBarHomeCustom({
    Key key,
    @required this.urlAvatar,
    @required this.folded,
    @required this.nameTextAppBar,
    @required this.isDarkMode,
    @required this.animationController,
    @required this.angle,
    @required this.onTap,
    @required this.textEditingController,
    @required this.onTapTextField,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _AppBarHomeCustomState createState() => _AppBarHomeCustomState();
}

class _AppBarHomeCustomState extends State<AppBarHomeCustom> {
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
                        widget.urlAvatar != null ? widget.urlAvatar : "https://firebasestorage.googleapis.com/v0/b/codeeduapp.appspot.com/o/21-avatar-outline.gif?alt=media&token=7b98a6a0-15c8-4fd0-9d78-2ed2d468112a",
                        fit: BoxFit.contain,
                      )
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: widget.folded ? AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    child: Text(
                      (widget.nameTextAppBar != null) ? "Hello ${widget.nameTextAppBar}!" : "Hello Anonymous!",
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.grey
                      ),
                    ),
                  ) : Text(""),
                )
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                height: 45,
                width: widget.folded ? 45 : 320,
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                  color: widget.isDarkMode ? Color(0xFF313131) : Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: widget.isDarkMode ? null : Border.all(
                    color: Colors.grey,
                    width: 1
                  ),
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 375),
                      top: 3.5,
                      right: 7,
                      curve: Curves.easeOut,
                      child: AnimatedOpacity(
                        opacity: widget.folded ? 0.0 : 1.0,
                        duration: Duration(milliseconds: 200),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: widget.isDarkMode ? Color(0xFF181818) : Color(0xFFF9F9F9),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AnimatedBuilder(
                            animation: widget.animationController,
                            builder: (context, widgetAnimation) {
                              return Transform.rotate(
                                angle: widget.angle,
                                child: widgetAnimation,
                              );
                            },
                            child: GestureDetector(
                              onTap: widget.onTap,
                              child: Icon(
                                Icons.mic,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 375),
                      left: widget.folded ? 20 : 60,
                      curve: Curves.easeOut,
                      child: AnimatedOpacity(
                        opacity: widget.folded ? 0.0 : 1.0,
                        duration: Duration(milliseconds: 200),
                        child: Container(
                          height: 45,
                          width: 205,
                          child: TextField(
                            onTap: widget.onTapTextField,
                            controller: widget.textEditingController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).searchForAnything,
                              hintStyle: TextStyle(
                                color: Colors.blue[300]
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: widget.isDarkMode ? Color(0xFF313131) : Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(30),
                      child: IconButton(
                        onPressed: widget.onPressed,
                        icon: Icon(
                          widget.folded ? Icons.search : Icons.close,
                          color: Colors.grey,
                        ),
                        splashRadius: Material.defaultSplashRadius - 12,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}