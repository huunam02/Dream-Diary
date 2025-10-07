import '/base/lifecycle_state.dart';
import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/model/languege.dart';
import '/screen/languege/controller/languege_controller.dart';
import '/screen/languege/widget/item_languege.dart';
import '/screen/oboarding/onboarding.dart';
import '/util/view_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key, required this.isSetting});
  final bool isSetting;
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends LifecycleState<LanguageScreen> {
  final langCtl = Get.find<LanguageController>();

  @override
  void initState() {
    super.initState();
    langCtl.checkLanguege();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 48.0,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: widget.isSetting
                          ? GestureDetector(
                              onTap: () => Get.back(),
                              child: SvgPicture.asset(
                                "assets/icons/ic_journal_back.svg",
                                fit: BoxFit.cover,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    Text(
                      L.language.tr,
                      style: GlobalTextStyles.font18w700ColorBlack,
                    ),
                    GestureDetector(
                      onTap: () {
                        tapAndCheckInternet(() {
                          if (widget.isSetting) {
                            Get.back();
                            langCtl.saveLanguage();
                          } else {
                            langCtl.saveLanguage();
                            Get.off(() => const OnboardingScreen());
                          }
                        });
                      },
                      child: SvgPicture.asset(
                        "assets/icons/ic_check.svg",
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                  child: Obx(
                () => ListView.builder(
                  itemCount: langCtl.listLanguege.length,
                  itemBuilder: (context, index) {
                    Languege languege = langCtl.listLanguege[index];
                    return Obx(
                      () => ItemLanguege(
                        onTap: () {
                          langCtl.selectLanguage(index);
                        },
                        language: languege.name,
                        imagePath: languege.image,
                        isSelected:
                            langCtl.selectedLanguageIndex.value == index,
                      ),
                    );
                  },
                ),
              )),
            ],
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
    langCtl.checkLanguege();
  }

  @override
  void onKeyboardHint() {}

  @override
  void onKeyboardShow() {}
}
