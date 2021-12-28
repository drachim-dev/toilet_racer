// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static m0(name) => "${name} 级";

  static m1(seconds) => "存活${seconds}秒";

  static m2(name) => "由 ${name} 创作";

  static m3(appUrl, seconds) => "我持续了${seconds}的时间。你能坚持多长时间？\n\n${appUrl}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appDescription" : MessageLookupByLibrary.simpleMessage("你在排便时总是这么无聊吗？杜绝恶臭。\n把你的浴室变成一个神奇的避难所，成为厕所忍者🥷🏼🧻。\n只要别从马桶上掉下来就好，它很脏! 你能坚持多长时间？"),
    "appDescriptionShort" : MessageLookupByLibrary.simpleMessage("把你的浴室变成一个神奇的避难所，成为马桶忍者吧!"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("厕所飞人"),
    "commonBack" : MessageLookupByLibrary.simpleMessage("< 返回"),
    "overlayHelpLevelName" : m0,
    "overlayHelpStayOnMapText" : MessageLookupByLibrary.simpleMessage("呆在马桶上"),
    "overlayHelpSurviveText" : m1,
    "overlayHelpTapToStartText" : MessageLookupByLibrary.simpleMessage("点击开始"),
    "overlayHelpTapToTurnText" : MessageLookupByLibrary.simpleMessage("轻轻点一\n下就可以转身"),
    "pageCreditsAuthorsSectionText" : MessageLookupByLibrary.simpleMessage("作者"),
    "pageCreditsComposedBy" : m2,
    "pageCreditsImagesSectionText" : MessageLookupByLibrary.simpleMessage("图片"),
    "pageCreditsLicensesButtonText" : MessageLookupByLibrary.simpleMessage("许可证 >"),
    "pageCreditsMusicSectionText" : MessageLookupByLibrary.simpleMessage("音乐"),
    "pageCreditsTitle" : MessageLookupByLibrary.simpleMessage("鸣谢"),
    "pageGameOverHomeButtonText" : MessageLookupByLibrary.simpleMessage("首页"),
    "pageGameOverNextButtonText" : MessageLookupByLibrary.simpleMessage("下一个水平"),
    "pageGameOverRestartButtonText" : MessageLookupByLibrary.simpleMessage("重新开始"),
    "pageGameOverShareButtonText" : MessageLookupByLibrary.simpleMessage("分享"),
    "pageGameOverShareMessage" : m3,
    "pageGameOverTryAgainButtonText" : MessageLookupByLibrary.simpleMessage("再试一次"),
    "pageStartContinueButtonText" : MessageLookupByLibrary.simpleMessage("继续"),
    "pageStartCreditsButtonText" : MessageLookupByLibrary.simpleMessage("积分"),
    "pageStartPlayButtonText" : MessageLookupByLibrary.simpleMessage("播放"),
    "pageStartShuffleButtonText" : MessageLookupByLibrary.simpleMessage("摇一摇")
  };
}
