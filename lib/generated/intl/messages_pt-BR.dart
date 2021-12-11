// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_BR locale. All the
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
  String get localeName => 'pt_BR';

  static m0(seconds) => "Sobreviver\na ${seconds} seg";

  static m1(name) => "Composto por ${name}";

  static m2(appUrl, seconds) => "Durei ${seconds} segundos. Quanto tempo você pode durar?\n\n${appUrl}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appDescription" : MessageLookupByLibrary.simpleMessage("Você está sempre tão entediado durante a defecação? Ponha um fim ao fedor.\nTransforme seu banheiro em um santuário mágico e torne-se o banheiro ninja 🥷🏼🧻\nSó não caia do vaso sanitário, está sujo! Quanto tempo você pode durar?"),
    "appDescriptionShort" : MessageLookupByLibrary.simpleMessage("Transforme seu banheiro em um santuário mágico e torne-se o ninja do banheiro!"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("Sanitário Racer"),
    "commonAppUrl" : MessageLookupByLibrary.simpleMessage(""),
    "commonBack" : MessageLookupByLibrary.simpleMessage("< voltar"),
    "overlayHelpStayOnMapText" : MessageLookupByLibrary.simpleMessage("Fique no\nbanheiro"),
    "overlayHelpSurviveText" : m0,
    "overlayHelpTapToStartText" : MessageLookupByLibrary.simpleMessage("Toque para\ncomeçar"),
    "overlayHelpTapToTurnText" : MessageLookupByLibrary.simpleMessage("Toque para\ngirar"),
    "pageCreditsAuthorsSectionText" : MessageLookupByLibrary.simpleMessage("Autores"),
    "pageCreditsComposedBy" : m1,
    "pageCreditsImagesSectionText" : MessageLookupByLibrary.simpleMessage("Imagens"),
    "pageCreditsLicensesButtonText" : MessageLookupByLibrary.simpleMessage("Licenças >"),
    "pageCreditsMusicSectionText" : MessageLookupByLibrary.simpleMessage("Música"),
    "pageCreditsTitle" : MessageLookupByLibrary.simpleMessage("Créditos"),
    "pageGameOverHomeButtonText" : MessageLookupByLibrary.simpleMessage("Início"),
    "pageGameOverNextButtonText" : MessageLookupByLibrary.simpleMessage("Próximo nível"),
    "pageGameOverRestartButtonText" : MessageLookupByLibrary.simpleMessage("Reinicie"),
    "pageGameOverShareButtonText" : MessageLookupByLibrary.simpleMessage("Compartilhe"),
    "pageGameOverShareMessage" : m2,
    "pageGameOverTryAgainButtonText" : MessageLookupByLibrary.simpleMessage("Tente novamente"),
    "pageStartContinueButtonText" : MessageLookupByLibrary.simpleMessage("Continuar"),
    "pageStartCreditsButtonText" : MessageLookupByLibrary.simpleMessage("Créditos"),
    "pageStartPlayButtonText" : MessageLookupByLibrary.simpleMessage("Reproduzir"),
    "pageStartShuffleButtonText" : MessageLookupByLibrary.simpleMessage("Baralhamento")
  };
}
