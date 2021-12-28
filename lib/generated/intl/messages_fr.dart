// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static m0(name) => "Niveau ${name}";

  static m1(seconds) => "Survivre\n${seconds} sec";

  static m2(name) => "Composé par ${name}";

  static m3(appUrl, seconds) => "J\'ai tenu ${seconds} secondes. Combien de temps pouvez-vous tenir?\n\n${appUrl}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appDescription" : MessageLookupByLibrary.simpleMessage("Vous vous ennuyez toujours autant en déféquant ? Mettez fin à cette puanteur.\nTransformez votre salle de bain en un sanctuaire magique et devenez le ninja des toilettes 🥷🏼🧻.\nMais ne tombe pas des toilettes, c\'est sale ! Combien de temps pouvez-vous tenir ?"),
    "appDescriptionShort" : MessageLookupByLibrary.simpleMessage("Transformez votre salle de bain en un sanctuaire magique et devenez le ninja des toilettes !"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("Toilet Racer"),
    "commonBack" : MessageLookupByLibrary.simpleMessage("< back"),
    "overlayHelpLevelName" : m0,
    "overlayHelpStayOnMapText" : MessageLookupByLibrary.simpleMessage("Restez sur\nles toilettes"),
    "overlayHelpSurviveText" : m1,
    "overlayHelpTapToStartText" : MessageLookupByLibrary.simpleMessage("Tapez pour\ncommencer"),
    "overlayHelpTapToTurnText" : MessageLookupByLibrary.simpleMessage("Tapez pour\ntourner"),
    "pageCreditsAuthorsSectionText" : MessageLookupByLibrary.simpleMessage("Auteurs"),
    "pageCreditsComposedBy" : m2,
    "pageCreditsImagesSectionText" : MessageLookupByLibrary.simpleMessage("Images"),
    "pageCreditsLicensesButtonText" : MessageLookupByLibrary.simpleMessage("Licences >"),
    "pageCreditsMusicSectionText" : MessageLookupByLibrary.simpleMessage("Musique"),
    "pageCreditsTitle" : MessageLookupByLibrary.simpleMessage("Crédits"),
    "pageGameOverHomeButtonText" : MessageLookupByLibrary.simpleMessage("Accueil"),
    "pageGameOverNextButtonText" : MessageLookupByLibrary.simpleMessage("Niveau suivant"),
    "pageGameOverRestartButtonText" : MessageLookupByLibrary.simpleMessage("Redémarrer"),
    "pageGameOverShareButtonText" : MessageLookupByLibrary.simpleMessage("Partager"),
    "pageGameOverShareMessage" : m3,
    "pageGameOverTryAgainButtonText" : MessageLookupByLibrary.simpleMessage("Essayez à nouveau"),
    "pageStartContinueButtonText" : MessageLookupByLibrary.simpleMessage("Continuer"),
    "pageStartCreditsButtonText" : MessageLookupByLibrary.simpleMessage("Crédits"),
    "pageStartPlayButtonText" : MessageLookupByLibrary.simpleMessage("Jouer"),
    "pageStartShuffleButtonText" : MessageLookupByLibrary.simpleMessage("Shuffle")
  };
}
