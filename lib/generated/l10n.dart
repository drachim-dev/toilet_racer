// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Are you always so bored while defecating? Put an end to the stink.\nTurn your bathroom into a magical sanctuary and become the toilet ninja 🥷🏼🧻\nJust don't fall off the toilet, it's dirty! How long can you last?`
  String get appDescription {
    return Intl.message(
      'Are you always so bored while defecating? Put an end to the stink.\nTurn your bathroom into a magical sanctuary and become the toilet ninja 🥷🏼🧻\nJust don\'t fall off the toilet, it\'s dirty! How long can you last?',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }

  /// `Turn your bathroom into a magical sanctuary and become the toilet ninja!`
  String get appDescriptionShort {
    return Intl.message(
      'Turn your bathroom into a magical sanctuary and become the toilet ninja!',
      name: 'appDescriptionShort',
      desc: '',
      args: [],
    );
  }

  /// `Toilet Racer`
  String get appTitle {
    return Intl.message(
      'Toilet Racer',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `https://play.google.com/store/apps/details?id=dr.achim.toilet_racer`
  String get commonAppUrl {
    return Intl.message(
      'https://play.google.com/store/apps/details?id=dr.achim.toilet_racer',
      name: 'commonAppUrl',
      desc: '',
      args: [],
    );
  }

  /// `< back`
  String get commonBack {
    return Intl.message(
      '< back',
      name: 'commonBack',
      desc: '',
      args: [],
    );
  }

  /// `Stay on the\ntoilet`
  String get overlayHelpStayOnMapText {
    return Intl.message(
      'Stay on the\ntoilet',
      name: 'overlayHelpStayOnMapText',
      desc: '',
      args: [],
    );
  }

  /// `Survive\n{seconds} sec`
  String overlayHelpSurviveText(Object seconds) {
    return Intl.message(
      'Survive\n$seconds sec',
      name: 'overlayHelpSurviveText',
      desc: '',
      args: [seconds],
    );
  }

  /// `Tap to begin`
  String get overlayHelpTapToStartText {
    return Intl.message(
      'Tap to begin',
      name: 'overlayHelpTapToStartText',
      desc: '',
      args: [],
    );
  }

  /// `Tap to turn`
  String get overlayHelpTapToTurnText {
    return Intl.message(
      'Tap to turn',
      name: 'overlayHelpTapToTurnText',
      desc: '',
      args: [],
    );
  }

  /// `Authors`
  String get pageCreditsAuthorsSectionText {
    return Intl.message(
      'Authors',
      name: 'pageCreditsAuthorsSectionText',
      desc: '',
      args: [],
    );
  }

  /// `Composed by {name}`
  String pageCreditsComposedBy(Object name) {
    return Intl.message(
      'Composed by $name',
      name: 'pageCreditsComposedBy',
      desc: '',
      args: [name],
    );
  }

  /// `Images`
  String get pageCreditsImagesSectionText {
    return Intl.message(
      'Images',
      name: 'pageCreditsImagesSectionText',
      desc: '',
      args: [],
    );
  }

  /// `Licenses >`
  String get pageCreditsLicensesButtonText {
    return Intl.message(
      'Licenses >',
      name: 'pageCreditsLicensesButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get pageCreditsMusicSectionText {
    return Intl.message(
      'Music',
      name: 'pageCreditsMusicSectionText',
      desc: '',
      args: [],
    );
  }

  /// `Credits`
  String get pageCreditsTitle {
    return Intl.message(
      'Credits',
      name: 'pageCreditsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get pageGameOverHomeButtonText {
    return Intl.message(
      'Home',
      name: 'pageGameOverHomeButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Next level`
  String get pageGameOverNextButtonText {
    return Intl.message(
      'Next level',
      name: 'pageGameOverNextButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Restart`
  String get pageGameOverRestartButtonText {
    return Intl.message(
      'Restart',
      name: 'pageGameOverRestartButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get pageGameOverShareButtonText {
    return Intl.message(
      'Share',
      name: 'pageGameOverShareButtonText',
      desc: '',
      args: [],
    );
  }

  /// `I lasted {seconds} seconds. How long can you last?\n\n{appUrl}`
  String pageGameOverShareMessage(Object appUrl, Object seconds) {
    return Intl.message(
      'I lasted $seconds seconds. How long can you last?\n\n$appUrl',
      name: 'pageGameOverShareMessage',
      desc: '',
      args: [appUrl, seconds],
    );
  }

  /// `Try again`
  String get pageGameOverTryAgainButtonText {
    return Intl.message(
      'Try again',
      name: 'pageGameOverTryAgainButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get pageStartContinueButtonText {
    return Intl.message(
      'Continue',
      name: 'pageStartContinueButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Credits`
  String get pageStartCreditsButtonText {
    return Intl.message(
      'Credits',
      name: 'pageStartCreditsButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Play`
  String get pageStartPlayButtonText {
    return Intl.message(
      'Play',
      name: 'pageStartPlayButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Shuffle`
  String get pageStartShuffleButtonText {
    return Intl.message(
      'Shuffle',
      name: 'pageStartShuffleButtonText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'PT'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}