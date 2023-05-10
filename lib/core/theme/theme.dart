import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.blueAccent,
  fontFamily: 'Georgia',
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 40.0),
    displayLarge: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900),
    displayMedium: TextStyle(fontSize: 24.0),
    displaySmall: TextStyle(fontSize: 18.0),
    bodyLarge: TextStyle(fontSize: 14.0),
  ),
  colorScheme: const ColorScheme(
      primary: Color(0xffE2711D),
      secondary: Color(0xff800020),
      surface: Colors.white,
      background: Colors.grey,
      error: Color(0xffDC0037),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
);
