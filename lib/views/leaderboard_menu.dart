import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/services/game_service.dart';
import 'package:toilet_racer/generated/l10n.dart';

class LeaderboardMenu extends StatelessWidget {
  final GameService _gameService = locator<GameService>();

  final VoidCallback onBackToMenuPressed;

  LeaderboardMenu(this.onBackToMenuPressed, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuStyle = Theme.of(context).textTheme.headline4;

    final titleStyle = Theme.of(context).textTheme.headline3;
    final textStyle = Theme.of(context).textTheme.headline2;

    const blur = 10.0;
    const sectionSpacing = 24.0;
    const itemSpacing = sectionSpacing / 2;

    final localLeader = Leader('Your Score', _gameService.getLocalHighscore());
    final leaders = <Leader>[localLeader];

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        color: Colors.orangeAccent.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(kMenuScreenMargin),
              child: TextButton(
                onPressed: onBackToMenuPressed,
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(left: 0)),
                child: Text('< back', style: menuStyle),
              ),
            ),
            Text('Highscore', style: titleStyle),
            const SizedBox(height: sectionSpacing),
            Expanded(
              child: ListView.separated(
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.only(
                    left: kMenuScreenMargin,
                    right: kMenuScreenMargin,
                    bottom: kMenuScreenMargin / 2),
                itemCount: leaders.length,
                itemBuilder: (_, int index) => Center(
                    child: Text(leaders[index].score.toString(),
                        style: textStyle)),
                separatorBuilder: (_, __) =>
                    const SizedBox(height: itemSpacing),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLicense(BuildContext context) {
    final iconSize = Theme.of(context).iconTheme.size ?? 48.0;

    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => LicensePage(
        applicationName: S.of(context).appTitle,
        applicationIcon: Image.asset(
          'assets/images/icons/ic_launcher_round.png',
          width: iconSize,
          height: iconSize,
        ),
      ),
    ));
  }
}

class Leader {
  final String name;
  final double score;

  Leader(this.name, this.score);
}
