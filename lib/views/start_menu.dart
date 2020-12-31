import 'package:flutter/material.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/race_game.dart';

class StartMenu extends StatelessWidget {
  final RaceGame game;

  const StartMenu(this.game);

  @override
  Widget build(BuildContext context) {
    const foregroundColor = Colors.orangeAccent;
    const outlineColor = Colors.brown;
    const shadowWidth = 2.5;

    const buttonStyle = TextStyle(
      fontSize: 56,
      fontWeight: FontWeight.bold,
      color: foregroundColor,
      shadows: [
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
      ],
    );

    const titleStyle = TextStyle(
        fontSize: 72, color: Colors.brown, fontFamily: 'NerkoOne');

    const spacing = 36.0;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
    Text(title, style: titleStyle, textAlign: TextAlign.center),
    SizedBox(height: spacing * 3),
    FlatButton(
      child: Text('PLAY', style: buttonStyle),
      onPressed: game.startGame,
    ),
    SizedBox(height: spacing),
    FlatButton(
      child: Text('OPTIONS', style: buttonStyle),
      onPressed: () {},
    ),
    SizedBox(height: spacing),
    FlatButton(
      child: Text('QUIT', style: buttonStyle),
      onPressed: game.quitGame,
    ),
        ],
      );
  }
}