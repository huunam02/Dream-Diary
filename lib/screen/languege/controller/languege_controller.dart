import 'dart:ui';
import '/model/languege.dart';
import '/util/preferences_util.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  RxInt selectedLanguageIndex = 0.obs;
  var listLanguege = [
    Languege("English", "assets/images/english.png", "en"),
    Languege("Hindi", "assets/images/hindi.png", "hi"),
    Languege("Spanish", "assets/images/spanis.png", "es"),
    Languege("French", "assets/images/french.png", "fr"),
    Languege("German", "assets/images/german.png", "de"),
    Languege("Indonesian", "assets/images/indonesia.png", "id"),
    Languege("Portuguese", "assets/images/portuguese.png", "pt"),
  ].obs;
  RxString currentLang = PreferencesUtil.getLanguage().obs;

  void checkLanguege() {
    int index =
        listLanguege.indexWhere((lang) => lang.code == currentLang.value);
    if (index != -1) {
      Languege currentLang = listLanguege.removeAt(index);
      listLanguege.insert(0, currentLang);
      selectedLanguageIndex.value = 0;
    } else {
      int index = listLanguege.indexWhere((lang) => lang.code == "en");
      Languege currentLang = listLanguege.removeAt(index);
      listLanguege.insert(0, currentLang);
      selectedLanguageIndex.value = 0;
    }
  }

  String getCurrentLanguage() {
    int index =
        listLanguege.indexWhere((lang) => lang.code == currentLang.value);
    return listLanguege[index].name;
  }

  void selectLanguage(int index) {
    selectedLanguageIndex.value = index;
  }

  void saveLanguage() {
    Get.updateLocale(Locale(listLanguege[selectedLanguageIndex.value].code));
    currentLang.value = listLanguege[selectedLanguageIndex.value].code;
    PreferencesUtil.setLanguage(listLanguege[selectedLanguageIndex.value].code);
  }
}
