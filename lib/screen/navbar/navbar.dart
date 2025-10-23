import '/config/global_color.dart';
import '/config/global_text_style.dart';
import '/lang/l.dart';
import '../chat_bot/chat.dart';
import '/screen/dream/dream.dart';
import '../diary/create_diary/create_diary.dart';
import '../diary/diary/diary.dart';
import '/screen/navbar/controller/navbar_controller.dart';
import '/screen/setting/setting.dart';
import '/util/view_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const DiaryScreen(),
    const DreamScreen(),
    const ChatAIScreen(),
    const SettingScreen(),
  ];

  final navbarCtl = Get.find<NavbarController>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: GlobalColors.bgLight),
        child: Column(
          children: [
            Expanded(child: _screens[_selectedIndex]),
            Obx(
              () => navbarCtl.isShow.value
                  ? ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0)),
                      child: BottomAppBar(
                        height: 80,
                        color: GlobalColors.linearContainer2.colors.first,
                        child: Row(
                          children: [
                            buildNavBarItem(
                                _selectedIndex == 0
                                    ? "assets/icons/ic_journal_choice.svg"
                                    : "assets/icons/ic_journal.svg",
                                L.daily.tr,
                                0),
                            buildNavBarItem(
                                _selectedIndex == 1
                                    ? "assets/icons/ic_dream_choice.svg"
                                    : "assets/icons/ic_dream.svg",
                                L.dreams.tr,
                                1),
                            GestureDetector(
                              onTap: () {
                                tapAndCheckInternet(() {
                                  Get.to(() => const CreateDiaryScreen());
                                });
                              },
                              child: Container(
                                height: 56,
                                width: 56,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    gradient: GlobalColors.linearPrimary2,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Image.asset("assets/images/ic_add.png",
                                    width: 24.0,
                                    height: 24.0,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            buildNavBarItem(
                                _selectedIndex == 2
                                    ? "assets/icons/ic_chat_choice.svg"
                                    : "assets/icons/ic_chat.svg",
                                L.chat.tr,
                                2),
                            buildNavBarItem(
                                _selectedIndex == 3
                                    ? "assets/icons/ic_setting_choice.svg"
                                    : "assets/icons/ic_setting.svg",
                                L.settings.tr,
                                3),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildNavBarItem(String icon, String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => tapAndCheckInternet(() {
          _onItemTapped(index);
        }),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              height: 20,
              width: 20,
              fit: BoxFit.cover,
              color: _selectedIndex == index
                  ? GlobalColors.linearPrimary1.colors.first
                  : const Color(0xFF8A96B2),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              label,
              style: _selectedIndex == index
                  ? GlobalTextStyles.font10w400ColorBlack
                  : GlobalTextStyles.font10w400Color8A96B2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
