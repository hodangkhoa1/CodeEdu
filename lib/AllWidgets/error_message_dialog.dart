import 'package:code_edu/AllWidgets/button_error_video.dart';
import 'package:flutter/material.dart';

class ErrorMessageDialog extends StatelessWidget {
  final String title, description, buttonText;
  final bool isDarkMode;
  
  const ErrorMessageDialog({
    Key key,
    @required this.title,
    @required this.description,
    @required this.buttonText,
    @required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: isDarkMode ? Color(0xFF141221) : Colors.grey[200],
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
              color: isDarkMode ? Color(0xFF141221) : Colors.grey,
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
                title,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                  wordSpacing: 0.25,
                  letterSpacing: 0.25,
                  height: 1.5
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ButtonErrorVideo(
              text: buttonText,
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}