import '/base/lifecycle_state.dart';
import '/config/global_color.dart';
import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/screen/navbar/navbar.dart';
import '/util/preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/permission_controller.dart';
import 'package:flutter_switch/flutter_switch.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends LifecycleState<PermissionScreen> {
  final PermissionController permissionCtl = Get.find<PermissionController>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Center(
      child: Scaffold(
        body: Container(
          height: h,
          width: w,
          color: GlobalColors.bgLight,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 48.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    L.permission.tr,
                    style: GlobalTextStyles.font18w700ColorBlack,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 160,
                      width: 122,
                      child: Image.asset(
                        "assets/images/permission.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                        textAlign: TextAlign.center,
                        L.thisAppNeedsPermissions.tr,
                        style: GlobalTextStyles.font14w400ColorBlack),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: GlobalColors.linearContainer2),
                      height: h * 0.08,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            L.allowAccess.tr,
                            style: GlobalTextStyles.font14w400ColorBlack,
                          ),
                          Obx(
                            () => FlutterSwitch(
                              activeColor: const Color(0xFF4350B0),
                              inactiveColor: const Color(0xffD9D9D9),
                              width: 48.0,
                              height: 24.0,
                              valueFontSize: 20.0,
                              toggleSize: 20.0,
                              value: permissionCtl.isToggled.value,
                              borderRadius: 30.0,
                              padding: 2.2,
                              onToggle: (val) {
                                permissionCtl.requestAllPermission();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () async {
                        PreferencesUtil.setIsPermissionGranted(true);
                        PreferencesUtil.putFirstTime(false);
                        Get.offAll(() => const NavbarScreen());
                      },
                      child: Text(
                        L.continuePer.tr,
                        style: GlobalTextStyles.font14w600ColorBlack,
                      ),
                    ),
                  ),
                ),
                // ad
                SizedBox(
                  height: h * 0.3,
                )
              ],
            ),
          ),
        ),
      ),
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
    permissionCtl.checkPermission();
  }

  @override
  void onKeyboardHint() {}

  @override
  void onKeyboardShow() {}
}
