import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:toilet_racer/app/constants.dart';

class GameOverMenu extends StatelessWidget {
  final VoidCallback onBackToMenuPressed;
  final VoidCallback onPlayPressed;
  final double score;

  const GameOverMenu(this.onBackToMenuPressed, this.onPlayPressed, this.score);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headline2;
    final buttonStyle = Theme.of(context).textTheme.headline3;
    final dividerHeight = 5.0;
    final blur = 10.0;
    final backgroundColor = buttonStyle.color;

    const spacing = 16.0;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        padding: const EdgeInsets.all(kMenuScreenMargin),
        color: Colors.orangeAccent.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Divider(
                        thickness: dividerHeight, color: backgroundColor),
                  ),
                ),
                Icon(Icons.star_border, size: 128, color: backgroundColor),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Divider(
                        thickness: dividerHeight, color: backgroundColor),
                  ),
                ),
              ],
            ),
            Text(score.toString(), style: titleStyle),
            TextButton.icon(
              icon: Icon(Icons.share, color: backgroundColor),
              label: Text('Share'),
              onPressed: () => Share.share(
                  'I lasted $score seconds. How long can you last?\nhttps://play.google.com/store/apps/details?id=dr.achim.toilet_racer'),
            ),
            Divider(thickness: dividerHeight, color: backgroundColor),
            SizedBox(height: spacing),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                children: [
                  TextButton(
                    onPressed: onBackToMenuPressed,
                    child: Text('HOME', style: buttonStyle),
                  ),
                  SizedBox(height: spacing),
                  TextButton(
                    onPressed: onPlayPressed,
                    child: Text('TRY AGAIN', style: buttonStyle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
