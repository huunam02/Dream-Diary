import 'package:dream_diary/config/global_color.dart';
import 'package:dream_diary/screen/navbar/navbar.dart';
import 'package:dream_diary/util/preferences_util.dart';

import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/screen/languege/language.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3)).whenComplete(
      () {
        if (!PreferencesUtil.getFirstTime()) {
          Get.offAll(() => const NavbarScreen());
        } else {
          Get.off(() => const LanguageScreen(isSetting: false));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: GlobalColors.bgLight,
        body: BodyCustom(
          isShowBgImages: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                textAlign: TextAlign.center,
                L.titleSplash,
                style: GlobalTextStyles.font18w700ColorBlack,
              ),
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: w * 0.66,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(63.0),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.grey.shade800,
                          color: GlobalColors.linearPrimary1.colors.first,
                        ),
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
