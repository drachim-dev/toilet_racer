import 'dart:math' as math;

import 'package:flutter/material.dart';

const outlineColor = Colors.brown;

final toiletTheme = ThemeData(
    accentColor: Colors.orangeAccent,
    brightness: Brightness.dark,
    fontFamily: 'NerkoOne',
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 128),
      headline2: _getTextStyleWithShadow(96),
      headline3: _getTextStyleWithShadow(72),
      headline4: _getTextStyleWithShadow(36),
      headline5: _getTextStyleWithShadow(24),
      headline6: _getTextStyleWithShadow(16),
      button: _getTextStyleWithShadow(24)
    ).apply(
      displayColor: Colors.orangeAccent,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.orangeAccent,
      ),
    ));

TextStyle _getTextStyleWithShadow(double fontSize) {
  final shadowWidth = math.max((fontSize / 25), 1.0);

  final shadows = [
    Shadow(
        // bottomLeft
        offset: Offset(-shadowWidth, -shadowWidth),
        color: outlineColor),
    Shadow(
        // bottomRight
        offset: Offset(shadowWidth, -shadowWidth),
        color: outlineColor),
    Shadow(
        // topRight
        offset: Offset(shadowWidth, shadowWidth),
        color: outlineColor),
    Shadow(
        // topLeft
        offset: Offset(-shadowWidth, shadowWidth),
        color: outlineColor),
  ];

  return TextStyle(fontSize: fontSize, shadows: shadows);
}
