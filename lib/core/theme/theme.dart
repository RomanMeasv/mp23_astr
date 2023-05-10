import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.blueAccent,
  fontFamily: 'Nunito',
  textTheme: const TextTheme(

    titleLarge: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),

    displayLarge: TextStyle(fontSize: 20.0),
    displayMedium: TextStyle(fontSize: 16.0),
    displaySmall: TextStyle(fontSize: 12.0),

    bodyLarge: TextStyle(fontSize: 20.0),
    bodyMedium: TextStyle(fontSize: 16.0),
    bodySmall: TextStyle(fontSize: 12.0),

    labelLarge: TextStyle(fontSize: 20.0),
    labelMedium: TextStyle(fontSize: 16.0),
    labelSmall: TextStyle(fontSize: 12.0),

    headlineLarge: TextStyle(fontSize: 20.0),
    headlineMedium: TextStyle(fontSize: 16.0),
    headlineSmall: TextStyle(fontSize: 12.0),
    
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
