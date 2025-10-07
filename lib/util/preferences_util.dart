import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  static SharedPreferences? _pref;

  static Future<void> init() async {
    _pref ??= await SharedPreferences.getInstance();
  }

  static Future<void> setLanguage(String code) async {
    await _pref?.setString("language", code);
  }

  static String getLanguage() {
    return _pref?.getString("language") ??
        (Get.deviceLocale?.languageCode ?? 'en');
  }

  static Future<void> setIsDailyReminder(bool val) async {
    await _pref?.setBool("is_daily_reminder", val);
  }

  static bool getIsDailyReminder() {
    return _pref?.getBool("is_daily_reminder") ?? false;
  }

  static Future<void> setHourDailyReminder(int val) async {
    await _pref?.setInt("hour_daily_reminder", val);
  }

  static int getHourDailyReminder() {
    return _pref?.getInt("hour_daily_reminder") ?? 12;
  }

  static Future<void> setMinuteDailyReminder(int val) async {
    await _pref?.setInt("minute_daily_reminder", val);
  }

  static int getMinuteDailyReminder() {
    return _pref?.getInt("minute_daily_reminder") ?? 0;
  }

  static Future<void> setIsPermissionGranted(bool val) async {
    await _pref?.setBool("is_permission_granted", val);
  }

  static bool getIsPermissionGranted() {
    return _pref?.getBool("is_permission_granted") ?? false;
  }
  static Future<void> setIdChannelNoti(int id) async {
    await _pref?.setInt("channel_noti", id);
  }
  static int getIdChannelNoti() {
    return _pref?.getInt("channel_noti") ?? 0;
  }
  
  static Future<void> setRate() async {
    await _pref?.setBool("rated", true);
  }

  static bool isRated() {
    return _pref?.getBool("rated") ?? false;
  }

  static Future<void> setSelectFirstLanguage() async {
    await _pref?.setBool("select_first_language", true);
  }

  static bool isSelectFirstLanguage() {
    return _pref?.getBool("select_first_language") ?? false;
  }

  static void increaseCountOpenIntroScreen() {
    var count = getCountOpenIntroScreen();
    count++;
    _pref?.setInt("count_open_intro_screen", count);
  }

  static int getCountOpenIntroScreen() {
    return _pref?.getInt("count_open_intro_screen") ?? 0;
  }

  static Future<void> setForceShowUmp(bool value) async {
    await _pref?.setBool("force_show_ump", value);
  }

  static bool isForceShowUmp() {
    return _pref?.getBool("force_show_ump") ?? false;
  }

  static Future<void> setManualCleanerFrequencyValue(int value) async {
    await _pref?.setInt("manual_cleaner_frequency_value", value);
  }

  static int getManualCleanerFrequencyValue() {
    return _pref?.getInt("manual_cleaner_frequency_value") ?? 100;
  }

  static Future<void> saveCanRate() async {
    await _pref?.setBool("can_rate", false);
  }

  static bool getCanRate() {
    return _pref?.getBool("can_rate") ?? true;
  }

  static Future<void> putFirstTime(bool firstTime) async {
    await _pref?.setBool("firstTime", firstTime);
  }

  static bool getFirstTime() {
    return _pref?.getBool("firstTime") ?? true;
  }

  static void countClickGetStartedAtSuccessScreen() {
    var count = getCountClickGetStartedAtSuccessScreen();
    count++;
    _pref?.setInt("count_click_get_started_at_success_screen", count);
  }

  static int getCountClickGetStartedAtSuccessScreen() {
    return _pref?.getInt("count_click_get_started_at_success_screen") ?? 0;
  }
}
