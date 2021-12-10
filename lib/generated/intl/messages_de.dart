// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static m0(seconds) => "Überlebe %s sek";

  static m1(name) => "Komponiert von %s";

  static m2(score, appUrl) => "";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appDescription" : MessageLookupByLibrary.simpleMessage("Ist dir beim Stuhlgang auch immer langweilig? Mach Schluss mit dem Gestank.\nVerwandle deinen Schacht zu einem magischen Zufluchtsort und werde zum Toilet-Ninja 🥷🏼🧻\nFall nur nicht von der Toilette, es ist wirklich schmutzig! Wie lange hältst du durch?"),
    "appDescriptionShort" : MessageLookupByLibrary.simpleMessage("Verwandle dein Badezimmer in einen magischen Zufluchtsort und werde zum Toilet-Ninja!"),
    "appTitle" : MessageLookupByLibrary.simpleMessage(""),
    "commonAppUrl" : MessageLookupByLibrary.simpleMessage(""),
    "commonBack" : MessageLookupByLibrary.simpleMessage("< zurück"),
    "overlayHelpStayOnMapText" : MessageLookupByLibrary.simpleMessage("Bleib auf der Klobrille"),
    "overlayHelpSurviveText" : m0,
    "overlayHelpTapToStartText" : MessageLookupByLibrary.simpleMessage("Starten"),
    "overlayHelpTapToTurnText" : MessageLookupByLibrary.simpleMessage("Tippe zum Lenken"),
    "pageCreditsAuthorsSectionText" : MessageLookupByLibrary.simpleMessage("Autoren"),
    "pageCreditsComposedBy" : m1,
    "pageCreditsImagesSectionText" : MessageLookupByLibrary.simpleMessage("Bilder"),
    "pageCreditsLicensesButtonText" : MessageLookupByLibrary.simpleMessage("Lizenzen >"),
    "pageCreditsMusicSectionText" : MessageLookupByLibrary.simpleMessage("Musik"),
    "pageCreditsTitle" : MessageLookupByLibrary.simpleMessage("Credits"),
    "pageGameOverHomeButtonText" : MessageLookupByLibrary.simpleMessage("Menü"),
    "pageGameOverNextButtonText" : MessageLookupByLibrary.simpleMessage("Weiter"),
    "pageGameOverRestartButtonText" : MessageLookupByLibrary.simpleMessage("Neue Karriere"),
    "pageGameOverShareButtonText" : MessageLookupByLibrary.simpleMessage("Teilen"),
    "pageGameOverShareMessage" : m2,
    "pageGameOverTryAgainButtonText" : MessageLookupByLibrary.simpleMessage("Nochmal"),
    "pageStartContinueButtonText" : MessageLookupByLibrary.simpleMessage("Fortsetzen"),
    "pageStartCreditsButtonText" : MessageLookupByLibrary.simpleMessage("Credits"),
    "pageStartPlayButtonText" : MessageLookupByLibrary.simpleMessage("Start"),
    "pageStartShuffleButtonText" : MessageLookupByLibrary.simpleMessage("Zufallsspiel")
  };
}
