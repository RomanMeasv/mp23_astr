import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.blueAccent,
  fontFamily: 'Nunito',
  textTheme: const TextTheme(

    titleLarge: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),

    displayLarge: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),

    bodyLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),

    labelLarge: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
    labelMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    labelSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),

    headlineLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),


    ),
  colorScheme: const ColorScheme(
      primary: Color(0xffE2711D),
      secondary: Color(0xff800020),
      tertiary: Color(0xffF8F0DF),
      surface: Colors.white,
      background: Colors.grey,
      error: Color(0xffDC0037),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Color(0xffadb5bd),
      onError: Colors.white,
      brightness: Brightness.light,
    ),
);
