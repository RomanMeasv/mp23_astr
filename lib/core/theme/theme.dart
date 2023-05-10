import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.blueAccent,
  fontFamily: 'Georgia',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
  colorScheme: const ColorScheme(
      primary: Color(0xffFF5733),
      secondary: Colors.green,
      surface: Colors.white,
      background: Colors.grey,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
);
