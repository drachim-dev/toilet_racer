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

  static m0(name) => "Nível ${name}";

  static m1(seconds) => "Sobreviver\na ${seconds} seg";

  static m2(name) => "Composto por ${name}";

  static m3(appUrl, seconds) => "Durou ${seconds} segundos. Quanto tempo pode durar?\n\n${appUrl}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appDescription" : MessageLookupByLibrary.simpleMessage("Está sempre tão aborrecido durante a defecação? Ponha um fim ao mau cheiro.\nTransforme a sua casa de banho num santuário mágico e torne-se o ninja da sanita 🥷🏼🧻\nSó não caias da sanita, está suja! Quanto tempo se pode durar?"),
    "appDescriptionShort" : MessageLookupByLibrary.simpleMessage("Transforme seu banheiro em um santuário mágico e torne-se o ninja do banheiro!"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("Sanitário Racer"),
    "commonBack" : MessageLookupByLibrary.simpleMessage("< voltar"),
    "overlayHelpLevelName" : m0,
    "overlayHelpStayOnMapText" : MessageLookupByLibrary.simpleMessage("Ficar na casa\nde banho"),
    "overlayHelpSurviveText" : m1,
    "overlayHelpTapToStartText" : MessageLookupByLibrary.simpleMessage("Toque para\ncomeçar"),
    "overlayHelpTapToTurnText" : MessageLookupByLibrary.simpleMessage("Toque para\nvirar"),
    "pageCreditsAuthorsSectionText" : MessageLookupByLibrary.simpleMessage("Autores"),
    "pageCreditsComposedBy" : m2,
    "pageCreditsImagesSectionText" : MessageLookupByLibrary.simpleMessage("Imagens"),
    "pageCreditsLicensesButtonText" : MessageLookupByLibrary.simpleMessage("Licenças >"),
    "pageCreditsMusicSectionText" : MessageLookupByLibrary.simpleMessage("Música"),
    "pageCreditsTitle" : MessageLookupByLibrary.simpleMessage("Créditos"),
    "pageGameOverHomeButtonText" : MessageLookupByLibrary.simpleMessage("Início"),
    "pageGameOverNextButtonText" : MessageLookupByLibrary.simpleMessage("Nível seguinte"),
    "pageGameOverRestartButtonText" : MessageLookupByLibrary.simpleMessage("Reiniciar"),
    "pageGameOverShareButtonText" : MessageLookupByLibrary.simpleMessage("Partilhar"),
    "pageGameOverShareMessage" : m3,
    "pageGameOverTryAgainButtonText" : MessageLookupByLibrary.simpleMessage("Tente novamente"),
    "pageStartContinueButtonText" : MessageLookupByLibrary.simpleMessage("Continuar"),
    "pageStartCreditsButtonText" : MessageLookupByLibrary.simpleMessage("Créditos"),
    "pageStartPlayButtonText" : MessageLookupByLibrary.simpleMessage("Reproduzir"),
    "pageStartShuffleButtonText" : MessageLookupByLibrary.simpleMessage("Baralhamento")
  };
}
