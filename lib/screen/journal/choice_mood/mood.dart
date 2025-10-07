import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/model/mood.dart';
import '/screen/journal/choice_mood/controller/mood_controller.dart';
import '/screen/journal/journal/widget/mood_item.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChoiceMoodScreen extends StatefulWidget {
  const ChoiceMoodScreen({super.key});

  @override
  State<ChoiceMoodScreen> createState() => _ChoiceMoodScreenState();
}

class _ChoiceMoodScreenState extends State<ChoiceMoodScreen> {
  final moodCtl = Get.find<MoodController>();
  @override
  void initState() {
    super.initState();
    moodCtl.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BodyCustom(
          isShowBgImages: true,
          edgeInsetsPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 64.0,
                width: double.infinity,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 64.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(
                              "assets/icons/ic_journal_back.svg",
                              width: 24.0,
                              height: 24.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (moodCtl.isSelected.value) {
           
                                moodCtl.setlistMoodSelected();
                              }
                            },
                            child: Obx(
                              () => Text(
                                L.apply.tr,
                                style: moodCtl.isSelected.value
                                    ? GlobalTextStyles.font14w600Color3076C9
                                    : GlobalTextStyles.font14w600ColorBlackOp60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        L.moods.tr,
                        style: GlobalTextStyles.font18w700ColorBlack,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.all(12),
                  height: 44,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1D273E), // Màu đầu tiên
                          Color(0xFF212B45), // Màu thứ hai
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(32.0)),
                  child: TextField(
              
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (value) {
                      moodCtl.filter(value);
                    },
                    style: GlobalTextStyles.font14w400ColorBlack,
                    autofocus: false,
                    decoration: InputDecoration(
                        isCollapsed:
                            true, // Giảm padding mặc định trong InputDecoration
                        contentPadding: EdgeInsets
                            .zero, // Giảm khoảng cách trong InputDecoration
                        hintStyle: GlobalTextStyles.font14w400ColorBlackOp38,
                        hintText: L.searchMood.tr,
                        border: InputBorder.none,
                        prefixIcon: SvgPicture.asset(
                            "assets/icons/ic_journal_search_mood.svg")),
                  )),
              const SizedBox(
                height: 12.0,
              ),
              Expanded(
                  child: Obx(
                () => moodCtl.isSearch.value && moodCtl.listMoodSearch.isEmpty
                    ? Center(
                        child: Text(
                          L.noSearchResult.tr,
                          style: GlobalTextStyles.font14w400ColorBlackOp38,
                        ),
                      )
                    : SingleChildScrollView(
                        child: Wrap(
                          runSpacing: 10.0,
                          spacing: 12.0,
                          children: List.generate(
                              moodCtl.isSearch.value
                                  ? moodCtl.listMoodSearch.length
                                  : moodCtl.listMood.length, (index) {
                            final Mood mood = moodCtl.isSearch.value
                                ? moodCtl.listMoodSearch[index]
                                : moodCtl.listMood[index];
                            return GestureDetector(
                              onTap: () {
                                moodCtl.selectedMood(mood);
                                moodCtl.checkSelected();
                              },
                              child: CustomMoodItem1(mood: mood),
                            );
                          }),
                        ),
                      ),
              )),
            ],
          )),
    );
  }
}
