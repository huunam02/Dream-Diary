// import '/lang/l.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:timezone/timezone.dart' as tz;

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> onDidReceiveNotification(
//       NotificationResponse notificationResponse) async {
//     print("Notification receive");
//   }

//   static Future<void> init() async {
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings("@mipmap/ic_launcher");
//     const DarwinInitializationSettings iOSInitializationSettings =
//         DarwinInitializationSettings();

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iOSInitializationSettings,
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onDidReceiveNotification,
//       onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
//     );

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();
//   }

//   static Future<void> scheduleDailyNotification(int id, String title,
//       String body, TimeOfDay time, String channelId) async {
//     final now = DateTime.now();
//     final scheduledDate =
//         DateTime(now.year, now.month, now.day, time.hour, time.minute);

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       L.notification.tr,
//       "",
//       tz.TZDateTime.from(scheduledDate, tz.local),
//       NotificationDetails(
//         iOS: const DarwinNotificationDetails(),
//         android: AndroidNotificationDetails(
//           channelId, "daily$channelId",
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//       ),
//       matchDateTimeComponents: DateTimeComponents.time,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     );
//   }

//   static Future<void> cancelNotification() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//     await flutterLocalNotificationsPlugin.pendingNotificationRequests();
//   }
// }
