// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(name) => "Nivel ${name}";

  static String m1(seconds) => "Sobrevive\n${seconds}s";

  static String m2(name) => "Compuesto por ${name}";

  static String m3(appUrl, seconds) =>
      "He durado ${seconds} segundos. ¿Cuánto tiempo puedes durar? \n\n${appUrl}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appDescription": MessageLookupByLibrary.simpleMessage(
            "¿Siempre se aburre cuando defeca? Acaba con el mal olor.\nConvierte tu baño en un santuario mágico y sé un ninja del retrete 🥷🏼🧻.\nPero no te caigas en el retrete, ¡está muy sucio! ¿Cuánto tiempo podrás sobrevivir?"),
        "appDescriptionShort": MessageLookupByLibrary.simpleMessage(
            "Convierte tu baño en un santuario mágico y conviértete en un ninja del baño."),
        "appTitle": MessageLookupByLibrary.simpleMessage("Carrera de retretes"),
        "commonBack": MessageLookupByLibrary.simpleMessage("< volver"),
        "overlayHelpLevelName": m0,
        "overlayHelpStayOnMapText":
            MessageLookupByLibrary.simpleMessage("Quédate en\nel asiento"),
        "overlayHelpSurviveText": m1,
        "overlayHelpTapToStartText":
            MessageLookupByLibrary.simpleMessage("Toque para\nempezar"),
        "overlayHelpTapToTurnText":
            MessageLookupByLibrary.simpleMessage("Toque para\ngirar"),
        "pageCreditsAuthorsSectionText":
            MessageLookupByLibrary.simpleMessage("Autores"),
        "pageCreditsComposedBy": m2,
        "pageCreditsImagesSectionText":
            MessageLookupByLibrary.simpleMessage("Imágenes"),
        "pageCreditsLicensesButtonText":
            MessageLookupByLibrary.simpleMessage("Licencias >"),
        "pageCreditsMusicSectionText":
            MessageLookupByLibrary.simpleMessage("Música"),
        "pageCreditsTitle": MessageLookupByLibrary.simpleMessage("Créditos"),
        "pageGameOverHomeButtonText":
            MessageLookupByLibrary.simpleMessage("Menú"),
        "pageGameOverNextButtonText":
            MessageLookupByLibrary.simpleMessage("Sigue"),
        "pageGameOverRestartButtonText":
            MessageLookupByLibrary.simpleMessage("Reiniciar"),
        "pageGameOverShareButtonText":
            MessageLookupByLibrary.simpleMessage("Compartir"),
        "pageGameOverShareMessage": m3,
        "pageGameOverTryAgainButtonText":
            MessageLookupByLibrary.simpleMessage("Otra vez"),
        "pageStartContinueButtonText":
            MessageLookupByLibrary.simpleMessage("Continuar"),
        "pageStartCreditsButtonText":
            MessageLookupByLibrary.simpleMessage("Créditos"),
        "pageStartPlayButtonText":
            MessageLookupByLibrary.simpleMessage("Jugar"),
        "pageStartShuffleButtonText":
            MessageLookupByLibrary.simpleMessage("Aleatorio")
      };
}
