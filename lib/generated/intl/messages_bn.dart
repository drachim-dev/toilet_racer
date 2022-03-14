// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a bn locale. All the
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
  String get localeName => 'bn';

  static String m0(name) => "স্তর ${name}";

  static String m1(seconds) => "${seconds} সেকেন্ড\nবেঁচে থাকুন";

  static String m2(name) => "${name} দ্বারা রচিত";

  static String m3(appUrl, seconds) =>
      "আমি ${seconds} সেকেন্ড টিকেছিলাম। আপনি কতক্ষণ থাকতে পারবেন?\n\n${appUrl}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appDescription": MessageLookupByLibrary.simpleMessage(
            "আপনি কি সবসময় মলত্যাগ করতে গিয়ে বিরক্ত হন? দুর্গন্ধের অবসান ঘটাও।\nআপনার বাথরুমকে একটি জাদুকরী অভয়ারণ্যে পরিণত করুন এবং টয়লেট নিনজা হয়ে উঠুন 🥷🏼🧻\nশুধু টয়লেট থেকে পড়ে যাবেন না, এটা নোংরা! কতক্ষণ স্থায়ী হতে পারে?"),
        "appDescriptionShort": MessageLookupByLibrary.simpleMessage(
            "আপনার বাথরুমকে একটি যাদুকরী অভয়ারণ্যে পরিণত করুন এবং টয়লেট নিনজা হয়ে উঠুন!"),
        "appTitle": MessageLookupByLibrary.simpleMessage("টয়লেট রেসার"),
        "commonBack": MessageLookupByLibrary.simpleMessage("< ফিরে"),
        "overlayHelpLevelName": m0,
        "overlayHelpStayOnMapText":
            MessageLookupByLibrary.simpleMessage("টয়লেটে থাকুন"),
        "overlayHelpSurviveText": m1,
        "overlayHelpTapToStartText":
            MessageLookupByLibrary.simpleMessage("শুরু করতে\nআলতো চাপুন"),
        "overlayHelpTapToTurnText":
            MessageLookupByLibrary.simpleMessage("ঘুরতে\nট্যাপ করুন"),
        "pageCreditsAuthorsSectionText":
            MessageLookupByLibrary.simpleMessage("লেখক"),
        "pageCreditsComposedBy": m2,
        "pageCreditsImagesSectionText":
            MessageLookupByLibrary.simpleMessage("ছবি"),
        "pageCreditsLicensesButtonText":
            MessageLookupByLibrary.simpleMessage("লাইসেন্স >"),
        "pageCreditsMusicSectionText":
            MessageLookupByLibrary.simpleMessage("সঙ্গীত"),
        "pageCreditsTitle": MessageLookupByLibrary.simpleMessage("ক্রেডিট"),
        "pageGameOverHomeButtonText":
            MessageLookupByLibrary.simpleMessage("বাড়ি"),
        "pageGameOverNextButtonText":
            MessageLookupByLibrary.simpleMessage("পরবর্তী ধাপ"),
        "pageGameOverRestartButtonText":
            MessageLookupByLibrary.simpleMessage("আবার শুরু"),
        "pageGameOverShareButtonText":
            MessageLookupByLibrary.simpleMessage("শেয়ার করুন"),
        "pageGameOverShareMessage": m3,
        "pageGameOverTryAgainButtonText":
            MessageLookupByLibrary.simpleMessage("আবার চেষ্টা করুন"),
        "pageStartContinueButtonText":
            MessageLookupByLibrary.simpleMessage("চালিয়ে যান"),
        "pageStartCreditsButtonText":
            MessageLookupByLibrary.simpleMessage("ক্রেডিট"),
        "pageStartPlayButtonText": MessageLookupByLibrary.simpleMessage("খেলা"),
        "pageStartShuffleButtonText":
            MessageLookupByLibrary.simpleMessage("অদলবদল")
      };
}
