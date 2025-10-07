// import '/lang/l.dart';
// import '/services/notification.dart';
// import '/util/preferences_util.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// class SettingController extends GetxController {
//   RxBool isDailyReminder = PreferencesUtil.getIsDailyReminder().obs;
//   RxInt hourDailyReminder = PreferencesUtil.getHourDailyReminder().obs;
//   RxInt minuteDailyReminder = PreferencesUtil.getMinuteDailyReminder().obs;

//   void setHourMinuteDailyReminder(int hour, int minute) async {
//     int channelNoti = PreferencesUtil.getIdChannelNoti();
//     hourDailyReminder.value = hour;
//     minuteDailyReminder.value = minute;
//     await PreferencesUtil.setHourDailyReminder(hour);
//     await PreferencesUtil.setMinuteDailyReminder(minute);
//     print(channelNoti + 1);
//     if (isDailyReminder.value) {
//       await NotificationService.cancelNotification();
//       await NotificationService.scheduleDailyNotification(
//           1,
//           "DreamApp: Journal & Dictionary",
//           "",
//           TimeOfDay(
//               hour: hourDailyReminder.value, minute: minuteDailyReminder.value),
//           "notification_channel${channelNoti + 1}");
//       await PreferencesUtil.setIdChannelNoti(channelNoti + 1);
//     }
//   }

//   void setDailyReminder(bool val) async {
//     var permissionNoti = await Permission.notification.status;
//     if (permissionNoti.isGranted) {
//       int channelNoti = PreferencesUtil.getIdChannelNoti();
//       print(channelNoti);
//       await PreferencesUtil.setIsDailyReminder(val);
//       isDailyReminder.value = val;
//       if (val) {
//         NotificationService.scheduleDailyNotification(
//             1,
//             "DreamApp: Journal & Dictionary",
//             L.notification.tr,
//             TimeOfDay(
//                 hour: hourDailyReminder.value,
//                 minute: minuteDailyReminder.value),
//             "notification_channel${channelNoti + 1}");
//         await PreferencesUtil.setIdChannelNoti(channelNoti + 1);
//       } else {
//         await NotificationService.cancelNotification();
//       }
//     }
//   }
// }
