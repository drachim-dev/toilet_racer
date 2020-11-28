import 'package:flutter/material.dart';
import 'package:toilet_racer/app/constants.dart';

class StartMenu extends StatelessWidget {
  final Function startGame;
  final Function quitGame;

  const StartMenu({
    Key key,
    this.startGame,
    this.quitGame,
  }) : super(key: key);

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
        fontSize: 64, color: Colors.brown, fontWeight: FontWeight.bold);

    const spacing = 36.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: titleStyle, textAlign: TextAlign.center),
        SizedBox(height: spacing * 3),
        FlatButton(
          child: Text('PLAY', style: buttonStyle),
          onPressed: startGame,
        ),
        SizedBox(height: spacing),
        FlatButton(
          child: Text('OPTIONS', style: buttonStyle),
          onPressed: () {},
        ),
        SizedBox(height: spacing),
        FlatButton(
          child: Text('QUIT', style: buttonStyle),
          onPressed: quitGame,
        ),
      ],
    );
  }
}
