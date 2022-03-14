// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m0(name) => "レベル${name}";

  static String m1(seconds) => "${seconds} 秒間のサバイバル";

  static String m2(name) => "作曲者 ${name}";

  static String m3(appUrl, seconds) =>
      "${seconds}秒続きました。あなたはどれくらい長く続くことができますか？\n\n${appUrl}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appDescription": MessageLookupByLibrary.simpleMessage(
            "排泄中、いつも退屈してないか？この悪臭に終止符を打ちましょう。\nあなたのトイレを魔法のような聖域に変えて、トイレ・ニンジャになりましょう! ただ、便器から落ちないように、汚いからね。どのくらい持つの？"),
        "appDescriptionShort": MessageLookupByLibrary.simpleMessage(
            "トイレを魔法のサンクチュアリに変えて、トイレ忍者になろう"),
        "appTitle": MessageLookupByLibrary.simpleMessage("トイレットレーサー"),
        "commonBack": MessageLookupByLibrary.simpleMessage("< バック"),
        "overlayHelpLevelName": m0,
        "overlayHelpStayOnMapText":
            MessageLookupByLibrary.simpleMessage("トイレに残る"),
        "overlayHelpSurviveText": m1,
        "overlayHelpTapToStartText":
            MessageLookupByLibrary.simpleMessage("出発する"),
        "overlayHelpTapToTurnText":
            MessageLookupByLibrary.simpleMessage("タップして回す"),
        "pageCreditsAuthorsSectionText":
            MessageLookupByLibrary.simpleMessage("著者"),
        "pageCreditsComposedBy": m2,
        "pageCreditsImagesSectionText":
            MessageLookupByLibrary.simpleMessage("イメージ"),
        "pageCreditsLicensesButtonText":
            MessageLookupByLibrary.simpleMessage("ライセンス >"),
        "pageCreditsMusicSectionText":
            MessageLookupByLibrary.simpleMessage("音楽"),
        "pageCreditsTitle": MessageLookupByLibrary.simpleMessage("クレジット"),
        "pageGameOverHomeButtonText":
            MessageLookupByLibrary.simpleMessage("ホーム"),
        "pageGameOverNextButtonText":
            MessageLookupByLibrary.simpleMessage("次のレベル"),
        "pageGameOverRestartButtonText":
            MessageLookupByLibrary.simpleMessage("新しい経歴"),
        "pageGameOverShareButtonText":
            MessageLookupByLibrary.simpleMessage("シェア"),
        "pageGameOverShareMessage": m3,
        "pageGameOverTryAgainButtonText":
            MessageLookupByLibrary.simpleMessage("もう一回"),
        "pageStartContinueButtonText":
            MessageLookupByLibrary.simpleMessage("続ける"),
        "pageStartCreditsButtonText":
            MessageLookupByLibrary.simpleMessage("クレジット"),
        "pageStartPlayButtonText": MessageLookupByLibrary.simpleMessage("プレイ"),
        "pageStartShuffleButtonText":
            MessageLookupByLibrary.simpleMessage("ランダムゲーム")
      };
}
