import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:ui';

final ThemeData themeDataLight = new ThemeData(
    brightness: Brightness.light,
    primaryColorLight: Color(0xff1D2229),
    primaryColor: Colors.white,
    primaryColorBrightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[200],
    accentColor: Color(0xff1D2229),
    buttonColor: Colors.black,
    accentColorBrightness: Brightness.light,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      centerTitle: true,
    ));

final ThemeData themeDataDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    primaryColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff353a3f),
    accentColor: Color(0xff1D2229),
    accentColorBrightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: Colors.black54,
      centerTitle: true,
    ));
