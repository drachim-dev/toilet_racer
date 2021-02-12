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
      fontSize: 96,
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

    const titleStyle =
        TextStyle(fontSize: 128, color: Colors.brown, fontFamily: 'NerkoOne');

    const spacing = 72.0;
    const buttonSpacing = 36.0;

    return Padding(
      padding: const EdgeInsets.all(startMenuMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              children: [
                Text(
                  title,
                  style: titleStyle,
                ),
                SizedBox(height: spacing * 2),
                TextButton(
                  child: Text('PLAY', style: buttonStyle),
                  onPressed: game.startGame,
                ),
                SizedBox(height: buttonSpacing),
                TextButton(
                  child: Text('OPTIONS', style: buttonStyle),
                  onPressed: () {},
                ),
                SizedBox(height: buttonSpacing),
                TextButton(
                  child: Text('QUIT', style: buttonStyle),
                  onPressed: game.quitGame,
                ),
                SizedBox(height: spacing),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
