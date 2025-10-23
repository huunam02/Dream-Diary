import 'screen/chat_bot/controller/chat_controller.dart';
import '/screen/dream/controller/dream_controller.dart';
import 'screen/diary/choice_mood/controller/mood_controller.dart';
import 'screen/diary/diary/controller/journal_controller.dart';
import '/screen/languege/controller/languege_controller.dart';
import '/screen/navbar/controller/navbar_controller.dart';
import '/screen/permission/controller/permission_controller.dart';
import '/util/preferences_util.dart';
import 'package:get/get.dart';

Future<void> init() async {
  await PreferencesUtil.init();

  final languageController = LanguageController();
  Get.lazyPut(() => languageController, fenix: true);

  final permissonController = PermissionController();
  Get.lazyPut(() => permissonController, fenix: true);

  final moodController = MoodController();
  Get.lazyPut(() => moodController, fenix: true);

  final diaryController = DiaryController();
  Get.lazyPut(() => diaryController, fenix: true);

  final dreamController = DreamController();
  Get.lazyPut(() => dreamController, fenix: true);
  
  final chatController = ChatController();
  Get.lazyPut(() => chatController, fenix: true);
  
  final navbarController = NavbarController();
  Get.lazyPut(() => navbarController, fenix: true);
}
