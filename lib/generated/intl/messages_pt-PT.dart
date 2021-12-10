// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_PT locale. All the
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
  String get localeName => 'pt_PT';

  static m0(seconds) => "Sobreviver a %s seg";

  static m1(name) => "Composto por %s";

  static m2(score, appUrl) => "Durou %s segundos. Quanto tempo pode durar?{\\i1}n%s";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appDescription" : MessageLookupByLibrary.simpleMessage("Está sempre tão aborrecido durante a defecação? Ponha um fim ao mau cheiro.\nTransforme a sua casa de banho num santuário mágico e torne-se o ninja da sanita 🥷🏼🧻\nSó não caias da sanita, está suja! Quanto tempo se pode durar?"),
    "appDescriptionShort" : MessageLookupByLibrary.simpleMessage("Transforme a sua casa de banho num santuário mágico e torne-se o ninja da casa de banho!"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("Sanita Racer"),
    "commonAppUrl" : MessageLookupByLibrary.simpleMessage(""),
    "commonBack" : MessageLookupByLibrary.simpleMessage("< voltar"),
    "overlayHelpStayOnMapText" : MessageLookupByLibrary.simpleMessage("Ficar na casa de banho"),
    "overlayHelpSurviveText" : m0,
    "overlayHelpTapToStartText" : MessageLookupByLibrary.simpleMessage("Toque para começar"),
    "overlayHelpTapToTurnText" : MessageLookupByLibrary.simpleMessage("Toque para virar"),
    "pageCreditsAuthorsSectionText" : MessageLookupByLibrary.simpleMessage("Autores"),
    "pageCreditsComposedBy" : m1,
    "pageCreditsImagesSectionText" : MessageLookupByLibrary.simpleMessage("Imagens"),
    "pageCreditsLicensesButtonText" : MessageLookupByLibrary.simpleMessage("Licenças >"),
    "pageCreditsMusicSectionText" : MessageLookupByLibrary.simpleMessage("Música"),
    "pageCreditsTitle" : MessageLookupByLibrary.simpleMessage("Créditos"),
    "pageGameOverHomeButtonText" : MessageLookupByLibrary.simpleMessage("Início"),
    "pageGameOverNextButtonText" : MessageLookupByLibrary.simpleMessage("Nível seguinte"),
    "pageGameOverRestartButtonText" : MessageLookupByLibrary.simpleMessage("Reiniciar"),
    "pageGameOverShareButtonText" : MessageLookupByLibrary.simpleMessage("Partilhar"),
    "pageGameOverShareMessage" : m2,
    "pageGameOverTryAgainButtonText" : MessageLookupByLibrary.simpleMessage("Tente novamente"),
    "pageStartContinueButtonText" : MessageLookupByLibrary.simpleMessage("Continuar"),
    "pageStartCreditsButtonText" : MessageLookupByLibrary.simpleMessage("Créditos"),
    "pageStartPlayButtonText" : MessageLookupByLibrary.simpleMessage("Reproduzir"),
    "pageStartShuffleButtonText" : MessageLookupByLibrary.simpleMessage("Baralhamento")
  };
}
