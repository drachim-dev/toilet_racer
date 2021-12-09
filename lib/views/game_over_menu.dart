import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/generated/l10n.dart';

class GameOverMenu extends StatelessWidget {
  final VoidCallback onBackToMenuPressed;
  final Future<void> Function(bool resetProgress) onPlayPressed;
  final double score;
  final bool canPlayNext;
  final bool hasCompletedGameMode;

  const GameOverMenu(
      {@required this.onBackToMenuPressed,
      @required this.onPlayPressed,
      @required this.score,
      @required this.canPlayNext,
      @required this.hasCompletedGameMode});

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
              label: Text(S.of(context).pageGameOverShareButtonText),
              onPressed: () {
                return Share.share(S.of(context).pageGameOverShareMessage(
                    score, S.of(context).commonAppUrl));
              },
            ),
            Divider(thickness: dividerHeight, color: backgroundColor),
            SizedBox(height: spacing),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                children: [
                  TextButton(
                    onPressed: onBackToMenuPressed,
                    child: Text(S.of(context).pageGameOverHomeButtonText,
                        style: buttonStyle),
                  ),
                  SizedBox(height: spacing),
                  _buildPlayButton(context, buttonStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextButton _buildPlayButton(
    BuildContext context,
    TextStyle buttonStyle,
  ) {
    final resetProgress = hasCompletedGameMode;

    final buttonText = hasCompletedGameMode
        ? S.of(context).pageGameOverRestartButtonText
        : canPlayNext
            ? S.of(context).pageGameOverNextButtonText
            : S.of(context).pageGameOverTryAgainButtonText;

    return TextButton(
      onPressed: () => onPlayPressed(resetProgress),
      child: Text(
        buttonText,
        style: buttonStyle,
      ),
    );
  }
}
