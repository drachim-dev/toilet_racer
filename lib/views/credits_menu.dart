import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsMenu extends StatelessWidget {
  final VoidCallback onBackToMenuPressed;

  const CreditsMenu(this.onBackToMenuPressed);

  @override
  Widget build(BuildContext context) {
    final menuStyle = Theme.of(context).textTheme.headline4;

    final sectionStyle = Theme.of(context).textTheme.headline4;
    final textStyle = Theme.of(context).textTheme.headline5;
    final urlStyle = Theme.of(context)
        .textTheme
        .headline6
        .copyWith(decoration: TextDecoration.underline);

    final blur = 10.0;
    final sectionSpacing = 24.0;
    final itemSpacing = sectionSpacing / 2;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        color: Colors.orangeAccent.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.all(kMenuScreenMargin),
              child: TextButton(
                onPressed: onBackToMenuPressed,
                style: TextButton.styleFrom(padding: EdgeInsets.only(left: 0)),
                child: Text('< back', style: menuStyle),
              ),
            ),
            Expanded(
              child: ListView(
                physics: ScrollPhysics(),
                padding: const EdgeInsets.only(
                    left: kMenuScreenMargin,
                    right: kMenuScreenMargin,
                    bottom: kMenuScreenMargin / 2),
                children: [
                  Text('Authors', style: sectionStyle),
                  Text('Dr. Jan Achim', style: textStyle),
                  SizedBox(height: itemSpacing),
                  Text('Dr. Jan Manni', style: textStyle),
                  SizedBox(height: sectionSpacing),
                  Text('Music', style: sectionStyle),
                  Text('Background music by Dr. Jan Roberto', style: textStyle),
                  SizedBox(height: itemSpacing),
                  Text('Fart sound effect', style: textStyle),
                  Linkify(
                    onOpen: _onOpen,
                    text: 'https://zapsplat.com/music/short-wet-bold-fart',
                    style: urlStyle,
                    linkStyle: urlStyle,
                  ),
                  SizedBox(height: sectionSpacing),
                  Text('Images', style: sectionStyle),
                  Text('Poop Vectors by Vecteezy', style: textStyle),
                  Linkify(
                    onOpen: _onOpen,
                    text: 'https://vecteezy.com/free-vector/poop',
                    style: urlStyle,
                    linkStyle: urlStyle,
                  ),
                  SizedBox(height: sectionSpacing),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.only(left: 0)),
                      onPressed: () => showLicense(context),
                      child: Text('Show licenses >', style: sectionStyle),
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

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}

class Credit {
  final String title, url;

  const Credit({this.title, this.url});
}
