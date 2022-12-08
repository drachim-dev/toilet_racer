import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/generated/l10n.dart';
import 'package:toilet_racer/models/play_option.dart';
import 'package:toilet_racer/race_game_mode.dart';

class GameOverMenu extends StatelessWidget {
  final GameMode? gameMode;
  final VoidCallback onBackToMenuPressed;
  final Function(PlayOption playOption) onPlayPressed;
  final double score;
  final bool canPlayNext;
  final bool hasCompletedGameMode;

  const GameOverMenu(
      {Key? key,
      required this.gameMode,
      required this.onBackToMenuPressed,
      required this.onPlayPressed,
      required this.score,
      required this.canPlayNext,
      required this.hasCompletedGameMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headline2!;
    final buttonStyle = Theme.of(context).textTheme.headline3!;
    const dividerHeight = 5.0;
    const blur = 10.0;
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
                Share.share(S.of(context).pageGameOverShareMessage(
                    S.of(context).commonAppUrl, score));
              },
            ),
            Divider(thickness: dividerHeight, color: backgroundColor),
            const SizedBox(height: spacing),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                children: [
                  TextButton(
                    onPressed: onBackToMenuPressed,
                    child: Text(
                      S.of(context).pageGameOverHomeButtonText,
                      style: buttonStyle,
                    ),
                  ),
                  const SizedBox(height: spacing),
                  if (canPlayNext) _buildNextButton(context, buttonStyle),
                  if (canPlayNext) const SizedBox(height: spacing),
                  TextButton(
                    onPressed: () => onPlayPressed(PlayOption.repeat),
                    child: Text(
                      S.of(context).pageGameOverTryAgainButtonText,
                      style: buttonStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextButton _buildNextButton(
    BuildContext context,
    TextStyle buttonStyle,
  ) {
    final String buttonText;

    final playOption =
        hasCompletedGameMode ? PlayOption.restart : PlayOption.next;

    if (gameMode?.isShuffle == true) {
      buttonText = S.of(context).pageStartShuffleButtonText;
    } else if (hasCompletedGameMode) {
      buttonText = S.of(context).pageGameOverRestartButtonText;
    } else {
      buttonText = S.of(context).pageGameOverNextButtonText;
    }

    return TextButton(
      onPressed: () => onPlayPressed(playOption),
      child: Text(
        buttonText,
        style: buttonStyle,
      ),
    );
  }
}
