import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.blueAccent,
  fontFamily: 'Georgia',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
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
