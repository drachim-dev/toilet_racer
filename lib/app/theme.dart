import 'package:flutter/material.dart';

const outlineColor = Colors.brown;
const shadowWidth = 2.5;
const shadows = [
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

final toiletTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'NerkoOne',
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 128),
      headline2: TextStyle(
        fontSize: 96,
        shadows: shadows,
      ),
      headline3: TextStyle(
        fontSize: 72,
        shadows: shadows,
      ),
      headline4: TextStyle(
        fontSize: 36,
        shadows: shadows,
      ),
    ).apply(
      displayColor: Colors.orangeAccent,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.orangeAccent,
      ),
    ));
