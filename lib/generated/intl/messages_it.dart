// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static m0(seconds) => "Sopravvivere %s sec";

  static m1(name) => "Composto da %s";

  static m2(score, appUrl) => "Ho resistito %s secondi. Quanto tempo puoi durare tu?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appDescription" : MessageLookupByLibrary.simpleMessage("Sei sempre così annoiato mentre defechi? Metti fine alla puzza.\nTrasforma il tuo bagno in un santuario magico e diventa il ninja del water 🥷🏼🧻\nBasta non cadere dal water, è sporco! Quanto puoi resistere?"),
    "appDescriptionShort" : MessageLookupByLibrary.simpleMessage("Trasforma il tuo bagno in un magico santuario e diventa il ninja del water!"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("Pilota di toilette"),
    "commonAppUrl" : MessageLookupByLibrary.simpleMessage(""),
    "commonBack" : MessageLookupByLibrary.simpleMessage("< indietro"),
    "overlayHelpStayOnMapText" : MessageLookupByLibrary.simpleMessage("Rimanere sulla toilette"),
    "overlayHelpSurviveText" : m0,
    "overlayHelpTapToStartText" : MessageLookupByLibrary.simpleMessage("Toccare per iniziare"),
    "overlayHelpTapToTurnText" : MessageLookupByLibrary.simpleMessage("Toccare per girare"),
    "pageCreditsAuthorsSectionText" : MessageLookupByLibrary.simpleMessage("Autori"),
    "pageCreditsComposedBy" : m1,
    "pageCreditsImagesSectionText" : MessageLookupByLibrary.simpleMessage("Immagini"),
    "pageCreditsLicensesButtonText" : MessageLookupByLibrary.simpleMessage("Licenze >"),
    "pageCreditsMusicSectionText" : MessageLookupByLibrary.simpleMessage("Musica"),
    "pageCreditsTitle" : MessageLookupByLibrary.simpleMessage("Crediti"),
    "pageGameOverHomeButtonText" : MessageLookupByLibrary.simpleMessage("Home"),
    "pageGameOverNextButtonText" : MessageLookupByLibrary.simpleMessage("Prossimo livello"),
    "pageGameOverRestartButtonText" : MessageLookupByLibrary.simpleMessage("Restart"),
    "pageGameOverShareButtonText" : MessageLookupByLibrary.simpleMessage("Condividi"),
    "pageGameOverShareMessage" : m2,
    "pageGameOverTryAgainButtonText" : MessageLookupByLibrary.simpleMessage("Prova di nuovo"),
    "pageStartContinueButtonText" : MessageLookupByLibrary.simpleMessage("Continua"),
    "pageStartCreditsButtonText" : MessageLookupByLibrary.simpleMessage("Crediti"),
    "pageStartPlayButtonText" : MessageLookupByLibrary.simpleMessage("Gioca"),
    "pageStartShuffleButtonText" : MessageLookupByLibrary.simpleMessage("Shuffle")
  };
}
