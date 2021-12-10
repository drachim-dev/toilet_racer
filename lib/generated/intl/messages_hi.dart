// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hi locale. All the
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
  String get localeName => 'hi';

  static m0(seconds) => "%s सेकंड जीवित रहें";

  static m1(name) => "%s . द्वारा रचित";

  static m2(score, appUrl) => "मैं %s सेकंड तक चला। आप कितने समय तक टिक सकते हैं?\\n%s";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appDescription" : MessageLookupByLibrary.simpleMessage("क्या आप हमेशा शौच करते समय इतने ऊब जाते हैं? बदबू खत्म करो।\nअपने बाथरूम को एक जादुई अभयारण्य में बदल दें और शौचालय निंजा बनें\nबस शौचालय से मत गिरो, यह गंदा है! कब तक तुम अस्तित्व में रह सकते हो?"),
    "appDescriptionShort" : MessageLookupByLibrary.simpleMessage("अपने बाथरूम को एक जादुई अभयारण्य में बदल दें और शौचालय निंजा बनें!"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("शौचालय रेसर"),
    "commonAppUrl" : MessageLookupByLibrary.simpleMessage(""),
    "commonBack" : MessageLookupByLibrary.simpleMessage("<पीछे"),
    "overlayHelpStayOnMapText" : MessageLookupByLibrary.simpleMessage("शौचालय पर रहो"),
    "overlayHelpSurviveText" : m0,
    "overlayHelpTapToStartText" : MessageLookupByLibrary.simpleMessage("शुरू करने के लिए टैप करें"),
    "overlayHelpTapToTurnText" : MessageLookupByLibrary.simpleMessage("मुड़ने के लिए टैप करें"),
    "pageCreditsAuthorsSectionText" : MessageLookupByLibrary.simpleMessage("लेखकों"),
    "pageCreditsComposedBy" : m1,
    "pageCreditsImagesSectionText" : MessageLookupByLibrary.simpleMessage("इमेजिस"),
    "pageCreditsLicensesButtonText" : MessageLookupByLibrary.simpleMessage("लाइसेंस >"),
    "pageCreditsMusicSectionText" : MessageLookupByLibrary.simpleMessage("संगीत"),
    "pageCreditsTitle" : MessageLookupByLibrary.simpleMessage("क्रेडिट"),
    "pageGameOverHomeButtonText" : MessageLookupByLibrary.simpleMessage("घर"),
    "pageGameOverNextButtonText" : MessageLookupByLibrary.simpleMessage("अगला स्तर"),
    "pageGameOverRestartButtonText" : MessageLookupByLibrary.simpleMessage("पुनः आरंभ करें"),
    "pageGameOverShareButtonText" : MessageLookupByLibrary.simpleMessage("साझा करना"),
    "pageGameOverShareMessage" : m2,
    "pageGameOverTryAgainButtonText" : MessageLookupByLibrary.simpleMessage("पुनः प्रयास करें"),
    "pageStartContinueButtonText" : MessageLookupByLibrary.simpleMessage("जारी रखें"),
    "pageStartCreditsButtonText" : MessageLookupByLibrary.simpleMessage("क्रेडिट"),
    "pageStartPlayButtonText" : MessageLookupByLibrary.simpleMessage("खेल"),
    "pageStartShuffleButtonText" : MessageLookupByLibrary.simpleMessage("मिश्रण")
  };
}
