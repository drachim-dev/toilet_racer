// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(name) => "Уровень ${name}";

  static String m1(seconds) => "Выжить\n${seconds} сек";

  static String m2(name) => "Составлено ${name}";

  static String m3(appUrl, seconds) =>
      "Я продержался ${seconds} секунд. Как долго ты можешь продержаться?\n\n${appUrl}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appDescription": MessageLookupByLibrary.simpleMessage(
            "Тебе всегда так скучно во время испражнения? Положите конец зловонию.\nПреврати свою ванную в волшебное убежище и стань туалетным ниндзя 🥷🏼🧻.\nТолько не упади с унитаза, он грязный! Как долго ты сможешь продержаться?"),
        "appDescriptionShort": MessageLookupByLibrary.simpleMessage(
            "Преврати свою ванную комнату в волшебное убежище и стань туалетным ниндзя!"),
        "appTitle": MessageLookupByLibrary.simpleMessage("Туалетный гонщик"),
        "commonBack": MessageLookupByLibrary.simpleMessage("< назад"),
        "overlayHelpLevelName": m0,
        "overlayHelpStayOnMapText":
            MessageLookupByLibrary.simpleMessage("Остаться\nна унитазе"),
        "overlayHelpSurviveText": m1,
        "overlayHelpTapToStartText":
            MessageLookupByLibrary.simpleMessage("Нажмите,\nчтобы начать"),
        "overlayHelpTapToTurnText":
            MessageLookupByLibrary.simpleMessage("Нажмите,\nчтобы\nповернуть"),
        "pageCreditsAuthorsSectionText":
            MessageLookupByLibrary.simpleMessage("Авторы"),
        "pageCreditsComposedBy": m2,
        "pageCreditsImagesSectionText":
            MessageLookupByLibrary.simpleMessage("Изображения"),
        "pageCreditsLicensesButtonText":
            MessageLookupByLibrary.simpleMessage("Лицензии >"),
        "pageCreditsMusicSectionText":
            MessageLookupByLibrary.simpleMessage("Музыка"),
        "pageCreditsTitle": MessageLookupByLibrary.simpleMessage("Кредиты"),
        "pageGameOverHomeButtonText":
            MessageLookupByLibrary.simpleMessage("Главная"),
        "pageGameOverNextButtonText":
            MessageLookupByLibrary.simpleMessage("Следующий уровень"),
        "pageGameOverRestartButtonText":
            MessageLookupByLibrary.simpleMessage("Restart"),
        "pageGameOverShareButtonText":
            MessageLookupByLibrary.simpleMessage("Поделиться"),
        "pageGameOverShareMessage": m3,
        "pageGameOverTryAgainButtonText":
            MessageLookupByLibrary.simpleMessage("Попробуйте еще раз"),
        "pageStartContinueButtonText":
            MessageLookupByLibrary.simpleMessage("Продолжить"),
        "pageStartCreditsButtonText":
            MessageLookupByLibrary.simpleMessage("Кредиты"),
        "pageStartPlayButtonText":
            MessageLookupByLibrary.simpleMessage("Играть"),
        "pageStartShuffleButtonText":
            MessageLookupByLibrary.simpleMessage("Shuffle")
      };
}
