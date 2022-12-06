import 'dart:math' as math;

import 'package:flutter/material.dart';

const primaryColor = Colors.brown;
const secondaryColor = Colors.orangeAccent;

const colorScheme = ColorScheme.dark(
  primary: primaryColor,
  secondary: secondaryColor,
);

final toiletTheme = ThemeData(
    colorScheme: colorScheme,
    brightness: Brightness.dark,
    fontFamily: 'NerkoOne',
    textTheme: TextTheme(
      headline1: const TextStyle(fontSize: 128),
      headline2: _getTextStyleWithShadow(96),
      headline3: _getTextStyleWithShadow(72),
      headline4: _getTextStyleWithShadow(36),
      headline5: _getTextStyleWithShadow(24),
      headline6: _getTextStyleWithShadow(16),
      button: _getTextStyleWithShadow(24),
    ).apply(displayColor: secondaryColor),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: secondaryColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange.shade100.withOpacity(0.25),
          elevation: 0,
          foregroundColor: Colors.white,
          shadowColor: Colors.orange.shade100.withOpacity(0.25)),
    ));

TextStyle _getTextStyleWithShadow(double fontSize) {
  final shadowWidth = math.max((fontSize / 25), 1.0);

  final shadows = [
    Shadow(
        // bottomLeft
        offset: Offset(-shadowWidth, -shadowWidth),
        color: primaryColor),
    Shadow(
        // bottomRight
        offset: Offset(shadowWidth, -shadowWidth),
        color: primaryColor),
    Shadow(
        // topRight
        offset: Offset(shadowWidth, shadowWidth),
        color: primaryColor),
    Shadow(
        // topLeft
        offset: Offset(-shadowWidth, shadowWidth),
        color: primaryColor),
  ];

  return TextStyle(fontSize: fontSize, shadows: shadows);
}
