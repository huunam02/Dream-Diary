import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/screen/navbar/navbar.dart';
import '/screen/oboarding/widget/item_pageview_onboarding.dart';
import '/screen/permission/permission.dart';
import '/util/preferences_util.dart';
import '/util/view_ex.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BodyCustom(
        isShowBgImages: true,
        edgeInsetsPadding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                controller: _pageController,
                children: [
                  ItemPageviewOnboarding(
                    imagePath: "assets/images/onboarding1.png",
                    title: L.titleBoarding1.tr,
                    description: L.contentBoarding1.tr,
                  ),
                  ItemPageviewOnboarding(
                    imagePath: "assets/images/onboarding2.png",
                    title: L.titleBoarding2.tr,
                    description: L.contentBoarding2.tr,
                  ),
                  ItemPageviewOnboarding(
                    imagePath: "assets/images/onboarding3.png",
                    title: L.titleBoarding3.tr,
                    description: L.contentBoarding3.tr,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController, // PageController
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor:
                          const Color.fromARGB(255, 71, 133, 209), // fix sot
                      dotColor: Colors.black.withOpacity(0.12),
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_currentPage < 2) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
             
                      } else {
                        tapAndCheckInternet(() {
                       
                          if (PreferencesUtil.getIsPermissionGranted()) {
                            Get.offAll(() => const NavbarScreen());
                          } else {
                            Get.off(() => const PermissionScreen());
                          }
                        });
                      }
                    },
                    child: Text(
                      L.next.tr,
                      style: GlobalTextStyles.font14w600ColorBlack,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 134.0,
              width: double.infinity, // vd ad
            )
          ],
        ),
      ),
    );
  }
}
