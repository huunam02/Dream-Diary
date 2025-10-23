import '/config/global_color.dart';
import '/config/global_const.dart';
import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/screen/languege/language.dart';
import '/screen/permission/controller/permission_controller.dart';
import '/screen/privacy/privacy.dart';
import '/screen/setting/widget/divider.dart';
import '/screen/setting/widget/item_setting.dart';
import '/util/preferences_util.dart';
import '/util/view_ex.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isClicking = false;
  int hour = PreferencesUtil.getHourDailyReminder();
  int minute = PreferencesUtil.getMinuteDailyReminder();
  final permissionCtl = Get.find<PermissionController>();
  String version = "";
  late PackageInfo packageInfo;
  void _getAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  void checkSpam() async {
    isClicking = true;
    await Future.delayed(const Duration(seconds: 1));
    isClicking = false;
  }

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    return BodyCustom(
        isShowBgImages: false,
        edgeInsetsPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 64.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      L.settings.tr,
                      style: GlobalTextStyles.font18w700ColorBlack,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                // height: h * 0.34,
                padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: GlobalColors.linearContainer2,
                    borderRadius: BorderRadius.circular(24.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ItemSettingCustom(
                      icon: "assets/icons/ic_language.svg",
                      title: L.language.tr,
                      ontap: () {
                        if (!isClicking) {
                          tapAndCheckInternet(() {
                            Get.to(() => const LanguageScreen(isSetting: true));
                          });
                          checkSpam();
                        }
                      },
                    ),
                    const DividerCustom(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ItemSettingCustom(
                      icon: "assets/icons/ic_share.svg",
                      title: L.share.tr,
                      ontap: () async {
                        if (!isClicking) {
                          tapAndCheckInternet(() async {
                            await Share.share(
                                "https://play.google.com/store/apps/details?id=${GlobalConst.kPackageName}");
                          });
                          checkSpam();
                        }
                      },
                    ),
                    const DividerCustom(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ItemSettingCustom(
                      icon: "assets/icons/ic_privacy.svg",
                      title: L.privacyPolicy.tr,
                      ontap: () {
                        if (!isClicking) {
                          tapAndCheckInternet(() {
                            Get.to(() => const PrivacyPolicyScreen());
                          });
                          checkSpam();
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Center(
                child: Text(
                  L.titleSplash,
                  style: GlobalTextStyles.font14w600ColorBlack,
                ),
              ),
              Center(
                child: Text(
                  "${L.version.tr} $version",
                  style: GlobalTextStyles.font12w400ColorBlack,
                ),
              )
            ],
          ),
        ));
  }
}
