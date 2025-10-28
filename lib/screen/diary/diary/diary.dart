import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/model/journal.dart';
import '../choice_mood/controller/mood_controller.dart';
import 'controller/journal_controller.dart';
import 'widget/diary_in_month_item.dart';
import '../search_diary/seach_diary.dart';
import '/util/view_ex.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final moodCtl = Get.find<MoodController>();
  final journalCtl = Get.find<DiaryController>();
  @override
  void initState() {
    super.initState();
    journalCtl.loadData();
    journalCtl.loadDataAndGroupByMonthAndDay();
    moodCtl.initData();
  }

  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    return BodyCustom(
      isShowBgImages: false,
      edgeInsetsPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(
            height: 64.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  L.daily.tr,
                  style: GlobalTextStyles.font18w700ColorBlack,
                ),
                GestureDetector(
                  onTap: () {
                    tapAndCheckInternet(() {
                      Get.to(() => const SearchDiaryScreen());
                    });
                  },
                  child: SvgPicture.asset(
                    "assets/icons/ic_journal_search.svg",
                    width: 24.0,
                    height: 24.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Expanded(
            child: Obx(
              () => journalCtl.isLoad.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : journalCtl.listJournalNew.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/ic_journal_notebook.png",
                              height: 123.0,
                              width: 123.0,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              L.startDiary.tr,
                              style: GlobalTextStyles.font16w600ColorBlack,
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              L.isEmptyJournalHome.tr,
                              style: GlobalTextStyles.font14w400ColorBlack,
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      : ListView.builder(
                          itemCount: journalCtl.listJournalNew.length,
                          itemBuilder: (context, index) {
                            Map<String, Map<String, List<Journal>>> monthData =
                                journalCtl.listJournalNew[index];
                            String getKeyMonth = monthData.keys.first;
                            var data = monthData[getKeyMonth];
                            return DiaryInMonthItemCustom(
                              onDetail: () {},
                              data: data!,
                              titleMonth: getKeyMonth,
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
