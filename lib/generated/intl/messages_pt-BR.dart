// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_BR locale. All the
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
  String get localeName => 'pt_BR';

  static String m0(name) => "Nível ${name}";

  static String m1(seconds) => "Sobreviver\na ${seconds} seg";

  static String m2(name) => "Composto por ${name}";

  static String m3(appUrl, seconds) =>
      "Durei ${seconds} segundos. Quanto tempo você pode durar?\n\n${appUrl}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appDescription": MessageLookupByLibrary.simpleMessage(
            "Você está sempre tão entediado durante a defecação? Ponha um fim ao fedor.\nTransforme seu banheiro em um santuário mágico e torne-se o banheiro ninja 🥷🏼🧻\nSó não caia do vaso sanitário, está sujo! Quanto tempo você pode durar?"),
        "appDescriptionShort": MessageLookupByLibrary.simpleMessage(
            "Transforme seu banheiro em um santuário mágico e torne-se o ninja do banheiro!"),
        "appTitle": MessageLookupByLibrary.simpleMessage("Sanitário Racer"),
        "commonBack": MessageLookupByLibrary.simpleMessage("< voltar"),
        "overlayHelpLevelName": m0,
        "overlayHelpStayOnMapText":
            MessageLookupByLibrary.simpleMessage("Fique no\nbanheiro"),
        "overlayHelpSurviveText": m1,
        "overlayHelpTapToStartText":
            MessageLookupByLibrary.simpleMessage("Toque para\ncomeçar"),
        "overlayHelpTapToTurnText":
            MessageLookupByLibrary.simpleMessage("Toque para\ngirar"),
        "pageCreditsAuthorsSectionText":
            MessageLookupByLibrary.simpleMessage("Autores"),
        "pageCreditsComposedBy": m2,
        "pageCreditsImagesSectionText":
            MessageLookupByLibrary.simpleMessage("Imagens"),
        "pageCreditsLicensesButtonText":
            MessageLookupByLibrary.simpleMessage("Licenças >"),
        "pageCreditsMusicSectionText":
            MessageLookupByLibrary.simpleMessage("Música"),
        "pageCreditsTitle": MessageLookupByLibrary.simpleMessage("Créditos"),
        "pageGameOverHomeButtonText":
            MessageLookupByLibrary.simpleMessage("Início"),
        "pageGameOverNextButtonText":
            MessageLookupByLibrary.simpleMessage("Próximo nível"),
        "pageGameOverRestartButtonText":
            MessageLookupByLibrary.simpleMessage("Reinicie"),
        "pageGameOverShareButtonText":
            MessageLookupByLibrary.simpleMessage("Compartilhe"),
        "pageGameOverShareMessage": m3,
        "pageGameOverTryAgainButtonText":
            MessageLookupByLibrary.simpleMessage("Tente novamente"),
        "pageStartContinueButtonText":
            MessageLookupByLibrary.simpleMessage("Continuar"),
        "pageStartCreditsButtonText":
            MessageLookupByLibrary.simpleMessage("Créditos"),
        "pageStartPlayButtonText":
            MessageLookupByLibrary.simpleMessage("Reproduzir"),
        "pageStartShuffleButtonText":
            MessageLookupByLibrary.simpleMessage("Baralhamento")
      };
}
