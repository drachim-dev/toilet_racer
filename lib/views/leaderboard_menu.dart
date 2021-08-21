import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toilet_racer/app/constants.dart';

class LeaderboardMenu extends StatelessWidget {
  final VoidCallback onBackToMenuPressed;

  const LeaderboardMenu(this.onBackToMenuPressed);

  @override
  Widget build(BuildContext context) {
    final menuStyle = Theme.of(context).textTheme.headline4;

    final titleStyle = Theme.of(context).textTheme.headline3;
    final textStyle = Theme.of(context).textTheme.headline4;

    final blur = 10.0;
    final sectionSpacing = 24.0;
    final itemSpacing = sectionSpacing / 2;

    final leaders = <String>['Achim', 'Manni', 'Seb'];

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
                style: TextButton.styleFrom(padding: EdgeInsets.only(left: 0)),
                child: Text('< back', style: menuStyle),
              ),
            ),
            Text('Highscore', style: titleStyle),
            SizedBox(height: sectionSpacing),
            Expanded(
              child: ListView.separated(
                physics: ScrollPhysics(),
                padding: const EdgeInsets.only(
                    left: kMenuScreenMargin,
                    right: kMenuScreenMargin,
                    bottom: kMenuScreenMargin / 2),
                itemCount: leaders.length,
                itemBuilder: (_, int index) =>
                    Center(child: Text(leaders[index], style: textStyle)),
                separatorBuilder: (_, __) => SizedBox(height: itemSpacing),
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
        applicationName: kTitle,
        applicationIcon: Image.asset(
          'assets/images/icons/ic_launcher_round.png',
          width: iconSize,
          height: iconSize,
        ),
      ),
    ));
  }

}