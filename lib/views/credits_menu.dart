import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsMenu extends StatelessWidget {
  final VoidCallback onBackToMenuPressed;

  const CreditsMenu(this.onBackToMenuPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuStyle = Theme.of(context).textTheme.headline4;

    final titleStyle = Theme.of(context).textTheme.headline3;
    final sectionStyle = Theme.of(context).textTheme.headline4;
    final textStyle = Theme.of(context).textTheme.headline5;
    final urlStyle = Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(decoration: TextDecoration.underline);

    const blur = 10.0;
    const sectionSpacing = 24.0;
    const itemSpacing = sectionSpacing / 2;

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
                child: Text(S.of(context).commonBack, style: menuStyle),
              ),
            ),
            Text(S.of(context).pageCreditsTitle, style: titleStyle),
            const SizedBox(height: sectionSpacing),
            Expanded(
              child: ListView(
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.only(
                    left: kMenuScreenMargin,
                    right: kMenuScreenMargin,
                    bottom: kMenuScreenMargin / 2),
                children: [
                  Center(
                      child: Text(S.of(context).pageCreditsAuthorsSectionText,
                          style: sectionStyle)),
                  Center(child: Text('Dr. Achim', style: textStyle)),
                  Center(
                    child: Linkify(
                      onOpen: _onOpen,
                      text: 'https://github.com/drachim-dev',
                      style: urlStyle,
                      linkStyle: urlStyle,
                    ),
                  ),
                  const SizedBox(height: itemSpacing),
                  Center(child: Text('Dr. Manni', style: textStyle)),
                  Center(
                    child: Linkify(
                      onOpen: _onOpen,
                      text: 'https://github.com/PMudra',
                      style: urlStyle,
                      linkStyle: urlStyle,
                    ),
                  ),
                  const SizedBox(height: sectionSpacing),
                  Center(
                      child: Text(S.of(context).pageCreditsMusicSectionText,
                          style: sectionStyle)),
                  Center(
                      child: Text('„Toilet Racer“',
                          style: textStyle, textAlign: TextAlign.center)),
                  Center(
                      child: Text(
                          S
                              .of(context)
                              .pageCreditsComposedBy('Roberto Risorto'),
                          style: textStyle,
                          textAlign: TextAlign.center)),
                  Center(
                    child: Linkify(
                      onOpen: _onOpen,
                      text: 'https://instagram.com/robertorisorto/',
                      style: urlStyle,
                      linkStyle: urlStyle,
                    ),
                  ),
                  const SizedBox(height: itemSpacing),
                  Center(
                      child: Text('„Short wet bold fart“', style: textStyle)),
                  Center(
                    child: Linkify(
                      onOpen: _onOpen,
                      text: 'https://zapsplat.com/music/short-wet-bold-fart',
                      style: urlStyle,
                      linkStyle: urlStyle,
                    ),
                  ),
                  const SizedBox(height: sectionSpacing),
                  Center(
                      child: Text(S.of(context).pageCreditsImagesSectionText,
                          style: sectionStyle)),
                  Center(
                      child:
                          Text('Poop Vectors by Vecteezy', style: textStyle)),
                  Center(
                    child: Linkify(
                      onOpen: _onOpen,
                      text: 'https://vecteezy.com/free-vector/poop',
                      style: urlStyle,
                      linkStyle: urlStyle,
                    ),
                  ),
                  const SizedBox(height: sectionSpacing),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(left: 0)),
                      onPressed: () => showLicense(context),
                      child: Text(S.of(context).pageCreditsLicensesButtonText,
                          style: sectionStyle),
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
        applicationName: S.of(context).appTitle,
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

  const Credit({required this.title, required this.url});
}
