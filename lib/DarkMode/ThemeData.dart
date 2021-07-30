import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: isDarkTheme ? Colors.grey: Colors.grey,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      backgroundColor: isDarkTheme ? Color(0xFF212121) : Color(0xffF1F5FB),
        accentColor: isDarkTheme ? Colors.white : Colors.black,
        accentIconTheme: isDarkTheme ? IconThemeData(color: Colors.black) : IconThemeData(color: Colors.white),
        dividerColor: isDarkTheme ? Colors.black12 : Colors.white54,
        appBarTheme: isDarkTheme ? AppBarTheme(
          color: Colors.black12,
        ) : AppBarTheme(
          color: Color(0xffF1F5FB),
        ),
    );

  }
}