import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/model/journal.dart';
import '/screen/journal/choice_mood/controller/mood_controller.dart';
import '/screen/journal/journal/controller/journal_controller.dart';
import '/screen/journal/journal/widget/journal_in_month_item.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchJournalScreen extends StatefulWidget {
  const SearchJournalScreen({super.key});

  @override
  State<SearchJournalScreen> createState() => _SearchJournalScreenState();
}

class _SearchJournalScreenState extends State<SearchJournalScreen> {
  final journalCtl = Get.find<JournalController>();
  final moodCtl = Get.find<MoodController>();
  final searchController = TextEditingController();
  String valSearch = "";
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    journalCtl.listJournalSearch.clear();
  }

  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BodyCustom(
            isShowBgImages: true,
            edgeInsetsPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
              SizedBox(
                height: 64.0,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        "assets/icons/ic_journal_back.svg",
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: Container(
                        alignment:
                            Alignment.centerLeft, // Đặt căn chỉnh của Container
                        height: 48,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D273E),
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        child: TextField(
                          autofocus: false,
                          controller: searchController,
                          style: GlobalTextStyles.font14w400ColorBlack,
                          textAlign: TextAlign
                              .start, // Đặt căn chỉnh nội dung TextField
                          textAlignVertical: TextAlignVertical
                              .center, // Căn chỉnh nội dung theo trục dọc
                          onChanged: (value) {
                            setState(() {
                              valSearch = value;
                            });
                            journalCtl.filterJournal(value);
                          },
                          decoration: InputDecoration(
                            isCollapsed:
                                true, // Giảm padding mặc định trong InputDecoration
                            contentPadding: EdgeInsets
                                .zero, // Giảm khoảng cách trong InputDecoration
                            hintText: L.search.tr,
                            hintStyle:
                                GlobalTextStyles.font14w400ColorBlackOp38,
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                  right: 4.0), // Điều chỉnh padding của icon
                              child: SvgPicture.asset(
                                "assets/icons/ic_journal_search.svg",
                                width: 20.0,
                                height: 20.0,
                              ),
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  searchController.text = "";
                                });
                              },
                              child: SvgPicture.asset(
                                "assets/icons/ic_close.svg",
                                width: 20.0,
                                height: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Obx(
                () => journalCtl.listJournalSearch.isEmpty
                    ? Center(
                        child: Text(
                          L.noSearchResult.tr,
                          style: GlobalTextStyles.font14w400ColorBlackOp38,
                        ),
                      )
                    : ListView.builder(
                        itemCount: journalCtl.listJournalSearch.length,
                        itemBuilder: (context, index) {
                          Map<String, Map<String, List<Journal>>> monthData =
                              journalCtl.listJournalSearch[index];
                          String getKeyMonth = monthData.keys.first;
                          var data = monthData[getKeyMonth];
                          return JournalInMonthItemCustom(
                              onDetail: () {
                            
                                Get.back();
                              },
                              titleMonth: getKeyMonth,
                              data: data!);
                        },
                      ),
              ))
            ])));
  }
}
