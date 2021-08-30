import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String desc;
  
  const TaskCardWidget({
    Key key,
    this.title,
    this.desc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 24
      ),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF181818) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDarkMode ? Colors.white : Colors.transparent,
          width: 1.0
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "(Unnamed Task)",
            style: TextStyle(
              color: isDarkMode ? Colors.white : Color(0xFF211551),
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              desc ?? "No description added",
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.grey : Color(0xFF86829D),
                height: 1.5,
              ),
            ),
          )
        ],
      )
    );
  }
}