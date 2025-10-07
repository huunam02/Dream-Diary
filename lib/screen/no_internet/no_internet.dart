import '/base/lifecycle_state.dart';
import '/config/global_color.dart';
import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/util/check_network.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/services.dart'; // Thêm import này để sử dụng SystemNavigator.pop()

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends LifecycleState<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BodyCustom(
          isShowBgImages: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 160.0,
                height: 160.0,
                child: Image.asset(
                  "assets/images/no_internet.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                L.noInternet.tr,
                style: GlobalTextStyles.font18w700ColorBlack,
              ),
              const SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                L.thereIsNoInternet.tr,
                style: GlobalTextStyles.font14w400ColorBlack,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  AppSettings.openAppSettings(type: AppSettingsType.wifi);
                },
                child: Container(
                    alignment: Alignment.center,
                    height: h * 0.06,
                    width: w * 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(39.0),
                        gradient: GlobalColors.linearPrimary1),
                    child: Text(
                      L.tryAgain.tr,
                      style: GlobalTextStyles.font14w600ColorBlack,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogBack() {
    Get.defaultDialog(
      title: "Thoát",
      middleText: "Bạn có muốn thoát",
      textConfirm: "OK",
      textCancel: "Cancel",
      onConfirm: () async {
        SystemNavigator.pop();
      },
    );
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    CheckNetwork().checkInternet((isNetwork) {
      if (isNetwork) {
        Get.back();
      }
    });
  }

  @override
  void onKeyboardHint() {}

  @override
  void onKeyboardShow() {}
}
