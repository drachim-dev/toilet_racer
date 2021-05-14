import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toilet_racer/app/constants.dart';

class CreditsMenu extends StatelessWidget {
  final VoidCallback onBackToMenuPressed;

  const CreditsMenu(this.onBackToMenuPressed);

  static final List _creditList = [
    'About',
    Credit(title: 'XYZ', url: 'XYZ.com'),
    'Images',
    'Music',
  ];

  @override
  Widget build(BuildContext context) {
    final menuStyle = Theme.of(context).textTheme.headline4;

    final sectionStyle = Theme.of(context).textTheme.headline3;
    final textStyle = Theme.of(context).textTheme.headline4;

    final blur = 10.0;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        color: Colors.orangeAccent.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(kStartMenuMargin),
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: onBackToMenuPressed,
                child: Text('< back', style: menuStyle),
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: kStartMenuMargin),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = _creditList[index];

                if (item is String) {
                  return Text(
                    item,
                    style: sectionStyle,
                  );
                }

                if (item is Credit) {
                  return Text(
                    item.title + item.url,
                    style: textStyle,
                  );
                }

                return Container();
              },
              itemCount: _creditList.length,
            ),
            TextButton(
              onPressed: () => showLicense(context),
              child: Text(
                'Show Licenses',
                style: textStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  void showLicense(BuildContext context) {
    final iconSize = Theme.of(context).iconTheme.size;

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

class Credit {
  final String title, url;

  const Credit({this.title, this.url});
}
