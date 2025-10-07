import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  RxBool isToggled = false.obs;
  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  Future<void> checkPermission() async {
    var status1 = await Permission.microphone.status;
    var status2 = await Permission.notification.status;
    var status3 = await Permission.storage.status;
    var status4 = await Permission.photos.status;
    print("permission $status1 $status2 $status3 $status4");

    if (status1.isGranted &&
        status2.isGranted &&
        (status3.isGranted || status4.isGranted)) {
      isToggled.value = true;
    } else if (status1.isPermanentlyDenied ||
        status2.isPermanentlyDenied ||
        (status3.isPermanentlyDenied && status4.isPermanentlyDenied)) {
      requestAllPermission();
    } else {
      isToggled.value = false;
    }
  }

  void requestAllPermission() async {
    var status1 = await Permission.microphone.request();
    var status2 = await Permission.storage.request();
    var status3 = await Permission.notification.request();
    var status4 = await Permission.photos.request();

    if (status1.isPermanentlyDenied ||
        status2.isPermanentlyDenied ||
        (status3.isPermanentlyDenied && status4.isPermanentlyDenied)) {
      await openAppSettings();
    }
  }

  Future<void> requestNotification() async {
    var status = await Permission.notification.request();
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  Future<void> requestMicro() async {
    var status = await Permission.microphone.request();
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  Future<void> requestStorage() async {
    var status1 = await Permission.storage.request();
    var status2 = await Permission.photos.request();
    if (status1.isPermanentlyDenied || status2.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}
