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
        Get.off(() => const LanguageScreen(
              isSetting: false,
            ));
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
        backgroundColor: Colors.transparent,
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
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
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
                          color: const Color(0xFF4350B0),
                        ),
                      ),
                      const SizedBox(
                        height: 14.0,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        L.descSplash.tr,
                        style: GlobalTextStyles.font12w400ColorBlackOp60,
                      ),
                      const SizedBox(
                        height: 20.0,
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
