// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(name) => "Livello ${name}";

  static String m1(seconds) => "Sopravvivere\n${seconds} sec";

  static String m2(name) => "Composto da ${name}";

  static String m3(appUrl, seconds) =>
      "Ho resistito ${seconds} secondi. Quanto tempo puoi durare tu?\n\n${appUrl}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appDescription": MessageLookupByLibrary.simpleMessage(
            "Sei sempre così annoiato mentre defechi? Metti fine alla puzza.\nTrasforma il tuo bagno in un santuario magico e diventa il ninja del water 🥷🏼🧻\nBasta non cadere dal water, è sporco! Quanto puoi resistere?"),
        "appDescriptionShort": MessageLookupByLibrary.simpleMessage(
            "Trasforma il tuo bagno in un magico santuario e diventa il ninja del water!"),
        "appTitle": MessageLookupByLibrary.simpleMessage("Pilota di toilette"),
        "commonBack": MessageLookupByLibrary.simpleMessage("< indietro"),
        "overlayHelpLevelName": m0,
        "overlayHelpStayOnMapText":
            MessageLookupByLibrary.simpleMessage("Rimanere\nsulla\ntoilette"),
        "overlayHelpSurviveText": m1,
        "overlayHelpTapToStartText":
            MessageLookupByLibrary.simpleMessage("Toccare per\niniziare"),
        "overlayHelpTapToTurnText":
            MessageLookupByLibrary.simpleMessage("Toccare per\ngirare"),
        "pageCreditsAuthorsSectionText":
            MessageLookupByLibrary.simpleMessage("Autori"),
        "pageCreditsComposedBy": m2,
        "pageCreditsImagesSectionText":
            MessageLookupByLibrary.simpleMessage("Immagini"),
        "pageCreditsLicensesButtonText":
            MessageLookupByLibrary.simpleMessage("Licenze >"),
        "pageCreditsMusicSectionText":
            MessageLookupByLibrary.simpleMessage("Musica"),
        "pageCreditsTitle": MessageLookupByLibrary.simpleMessage("Crediti"),
        "pageGameOverHomeButtonText":
            MessageLookupByLibrary.simpleMessage("Home"),
        "pageGameOverNextButtonText":
            MessageLookupByLibrary.simpleMessage("Prossimo livello"),
        "pageGameOverRestartButtonText":
            MessageLookupByLibrary.simpleMessage("Restart"),
        "pageGameOverShareButtonText":
            MessageLookupByLibrary.simpleMessage("Condividi"),
        "pageGameOverShareMessage": m3,
        "pageGameOverTryAgainButtonText":
            MessageLookupByLibrary.simpleMessage("Prova di nuovo"),
        "pageStartContinueButtonText":
            MessageLookupByLibrary.simpleMessage("Continua"),
        "pageStartCreditsButtonText":
            MessageLookupByLibrary.simpleMessage("Crediti"),
        "pageStartPlayButtonText":
            MessageLookupByLibrary.simpleMessage("Gioca"),
        "pageStartShuffleButtonText":
            MessageLookupByLibrary.simpleMessage("Shuffle")
      };
}
