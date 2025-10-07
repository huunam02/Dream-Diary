import 'package:get/get.dart';
import '/lang/de.dart';
import '/lang/en.dart';
import '/lang/es.dart';
import '/lang/fr.dart';
import '/lang/hi.dart';
import '/lang/id.dart';
import '/lang/pt.dart';

class TranslationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': enLanguage,
    'hi': hiLanguage,
    'es': esLanguage,
    'fr': frLanguage,
    'de': deLanguage,
    'id': idLanguage,
    'pt': ptLanguage
  };
}
