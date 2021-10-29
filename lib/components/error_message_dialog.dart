import 'package:code_edu/components/button_error_video.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorMessageDialog extends StatefulWidget {
  final String title, description, buttonText;
  final bool isDarkMode;
  final String imageMsg;
  final double sizeText;
  final Function onPressed;
  
  const ErrorMessageDialog({
    Key key,
    @required this.title,
    @required this.description,
    @required this.buttonText,
    @required this.isDarkMode,
    @required this.imageMsg,
    @required this.sizeText,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _ErrorMessageDialogState createState() => _ErrorMessageDialogState();
}

class _ErrorMessageDialogState extends State<ErrorMessageDialog> with TickerProviderStateMixin {
  AnimationController _errorController;

  @override
  void initState() {
    _errorController = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _errorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: widget.isDarkMode ? Color(0xFF141221) : Colors.grey[200],
      elevation: 32,
      insetPadding: EdgeInsets.all(32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: 4,
          left: 16,
          right: 16
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: widget.isDarkMode ? Color(0xFF141221) : Colors.grey,
              blurRadius: 16
            )
          ]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Lottie.asset(
              widget.imageMsg,
              height: MediaQuery.of(context).size.height * 0.2,
              controller: _errorController,
              onLoaded: (animation) {
                _errorController..duration = animation.duration..repeat(
                  reverse: true
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 13,
                right: 13,
                bottom: 10
              ),
              child: Text(
                widget.description,
                style: TextStyle(
                  fontSize: widget.sizeText,
                  wordSpacing: 0.25,
                  letterSpacing: 0.25,
                  height: 1.5
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ButtonErrorVideo(
              text: widget.buttonText,
              onPressed: widget.onPressed,
            ),
          ],
        ),
      ),
    );
  }
}