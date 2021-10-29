import 'package:code_edu/Screens/settings_screen/components/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class HeaderPage extends StatelessWidget {
  final String urlImage;
  final String name;
  final String email;
  final padding = EdgeInsets.symmetric(horizontal: 20);
  static const keyDarkMode = 'key-dark-mode';

  HeaderPage({
    Key key,
    @required this.urlImage,
    @required this.name,
    @required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);

    return Column(
      children: [
        Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(urlImage),
              ),
              SizedBox(width: 20),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 20,
                          color: isDarkMode ? Colors.white : Colors.black
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      SizedBox(height: 4),
                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode ? Colors.white : Colors.black
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SwitchSettingsTile(
          title: "Dark Mode",
          leading: IconWidget(
            icon: isDarkMode ? Icons.dark_mode : Icons.wb_sunny_outlined,
            color: Color(0xFF642ef3)
          ),
          settingKey: keyDarkMode,
          onChange: (_){},
        )
      ],
    );
  }
}