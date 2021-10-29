import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:google_fonts/google_fonts.dart';

//Bảng mã màu dùng cho Theme Dark
const Color primaryColorDark = Color(0xFF181818);
const Color accentColorDark = Colors.white;
const Color scaffoldBackgroundColorDark = Color(0xFF181818);
const Color canvasColorDark = Color(0xFF181818);
const Color colorDark = Color(0xFF202020);
const Color iconThemeColorDark = Colors.white;
const Color textStyleColorDark = Colors.white;

//Font Size cho cả hai Them
const double fontSize = 18;

//Bảng mã màu dùng cho Theme light
const Color accentColorLight = Colors.black;
const Color scaffoldBackgroundColorLight = Colors.white;
const Color canvasColorLight = Colors.white;
const Color colorLight = Colors.white;
const Color iconThemeColorLight = Colors.black;
const Color textStyleColorLight = Colors.blue;

final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);

class Themes {
  static final dark = ThemeData.dark().copyWith(
    primaryColor: primaryColorDark,
    accentColor: accentColorDark,
    scaffoldBackgroundColor: scaffoldBackgroundColorDark,
    canvasColor: canvasColorDark,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      color: colorDark,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(
        color: iconThemeColorDark
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: textStyleColorDark,
          fontSize: fontSize
        )
      )
    ),
  );

  static final light = ThemeData.light().copyWith(
    accentColor: accentColorLight,
    scaffoldBackgroundColor: scaffoldBackgroundColorLight,
    canvasColor: canvasColorLight,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      color: colorLight,
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: iconThemeColorLight
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: textStyleColorLight,
          fontSize: fontSize
        )
      )
    ),
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.grey[400] : Colors.grey
    )
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
    )
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold
    )
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.grey[100] : Colors.grey[600]
    )
  );
}