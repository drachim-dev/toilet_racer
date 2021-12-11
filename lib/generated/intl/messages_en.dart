// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(seconds) => "Survive\n${seconds} sec";

  static m1(name) => "Composed by ${name}";

  static m2(appUrl, seconds) => "I lasted ${seconds} seconds. How long can you last?\n\n${appUrl}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appDescription" : MessageLookupByLibrary.simpleMessage("Are you always so bored while defecating? Put an end to the stink.\nTurn your bathroom into a magical sanctuary and become the toilet ninja 🥷🏼🧻\nJust don\'t fall off the toilet, it\'s dirty! How long can you last?"),
    "appDescriptionShort" : MessageLookupByLibrary.simpleMessage("Turn your bathroom into a magical sanctuary and become the toilet ninja!"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("Toilet Racer"),
    "commonAppUrl" : MessageLookupByLibrary.simpleMessage("https://play.google.com/store/apps/details?id=dr.achim.toilet_racer"),
    "commonBack" : MessageLookupByLibrary.simpleMessage("< back"),
    "overlayHelpStayOnMapText" : MessageLookupByLibrary.simpleMessage("Stay on the\ntoilet"),
    "overlayHelpSurviveText" : m0,
    "overlayHelpTapToStartText" : MessageLookupByLibrary.simpleMessage("Tap to begin"),
    "overlayHelpTapToTurnText" : MessageLookupByLibrary.simpleMessage("Tap to turn"),
    "pageCreditsAuthorsSectionText" : MessageLookupByLibrary.simpleMessage("Authors"),
    "pageCreditsComposedBy" : m1,
    "pageCreditsImagesSectionText" : MessageLookupByLibrary.simpleMessage("Images"),
    "pageCreditsLicensesButtonText" : MessageLookupByLibrary.simpleMessage("Licenses >"),
    "pageCreditsMusicSectionText" : MessageLookupByLibrary.simpleMessage("Music"),
    "pageCreditsTitle" : MessageLookupByLibrary.simpleMessage("Credits"),
    "pageGameOverHomeButtonText" : MessageLookupByLibrary.simpleMessage("Home"),
    "pageGameOverNextButtonText" : MessageLookupByLibrary.simpleMessage("Next level"),
    "pageGameOverRestartButtonText" : MessageLookupByLibrary.simpleMessage("Restart"),
    "pageGameOverShareButtonText" : MessageLookupByLibrary.simpleMessage("Share"),
    "pageGameOverShareMessage" : m2,
    "pageGameOverTryAgainButtonText" : MessageLookupByLibrary.simpleMessage("Try again"),
    "pageStartContinueButtonText" : MessageLookupByLibrary.simpleMessage("Continue"),
    "pageStartCreditsButtonText" : MessageLookupByLibrary.simpleMessage("Credits"),
    "pageStartPlayButtonText" : MessageLookupByLibrary.simpleMessage("Play"),
    "pageStartShuffleButtonText" : MessageLookupByLibrary.simpleMessage("Shuffle")
  };
}
