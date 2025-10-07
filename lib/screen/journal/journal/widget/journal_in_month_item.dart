import '/config/global_color.dart';
import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/model/journal.dart';
import '/screen/journal/choice_mood/controller/mood_controller.dart';
import '/screen/journal/detail_journal/detail_journal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JournalInMonthItemCustom extends StatefulWidget {
  const JournalInMonthItemCustom(
      {super.key,
      required this.titleMonth,
      required this.data,
      required this.onDetail});
  final String titleMonth;
  final Map<String, List<Journal>> data;
  final GestureTapCallback onDetail;
  @override
  State<JournalInMonthItemCustom> createState() =>
      _JournalInMonthItemCustomState();
}

class _JournalInMonthItemCustomState extends State<JournalInMonthItemCustom> {
  final moodCtl = Get.find<MoodController>();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.titleMonth,
              style: GlobalTextStyles.font14w600ColorBlack,
            ),
            Text(
              "${countMonthJounal(widget.data)} ${L.journalLowCase.tr}", // Số lượng journal trong tháng
              style: GlobalTextStyles.font12w400ColorBlack,
            )
          ],
        ),
        const SizedBox(height: 10.0),
        ...widget.data.entries.map((entry) {
          String getKeyDay = entry.key;
          List<Journal> dayJournals = entry.value;
          return Column(
            children: List.generate(
              dayJournals.length,
              (index) {
                Journal journal = dayJournals[dayJournals.length - index - 1];
                return SizedBox(
                  height: h * 0.18,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: SizedBox(
                          width: 30.0,
                          height: double.infinity,
                          child: Stack(
                            children: [
                              Align(
                                alignment: const Alignment(-0.764, 0),
                                child: Container(
                                  height: double.infinity,
                                  color: const Color(0xFF242C42),
                                  width: 1,
                                ),
                              ),
                              index == 0
                                  ? Align(
                                      alignment: const Alignment(0.7, -0.7),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                                gradient:
                                                    GlobalColors.linearPrimary2,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          SizedBox(
                                            height: 18.0,
                                            width: 18.0,
                                            child: Text(
                                              getKeyDay,
                                              style: GlobalTextStyles
                                                  .font12w400ColorBlack,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                
                          Get.to(() => DetailJournal(journal: journal))!.then(
                            (value) {
                              widget.onDetail();
                            },
                          );
                        },
                        child: Container(
                          height: double.infinity,
                          width: w * 0.78,
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF212B45),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                journal.title,
                                style: GlobalTextStyles.font14w600ColorBlack,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              convertListIndexMood(journal.mood).isNotEmpty
                                  ? SizedBox(
                                      width: double.infinity,
                                      height: 32,
                                      child: ListView.builder(
                                        itemCount:
                                            convertListIndexMood(journal.mood)
                                                        .length >
                                                    1
                                                ? 2
                                                : 1,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final int indexMood =
                                              convertListIndexMood(
                                                  journal.mood)[index];
                                          return Container(
                                            margin: index == 0
                                                ? const EdgeInsets.only(
                                                    right: 8.0)
                                                : null,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 8),
                                            decoration: BoxDecoration(
                                              gradient:
                                                  GlobalColors.linearPrimary2,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  getFirstLetterOfFirstWord(
                                                      moodCtl
                                                          .listMood[indexMood]
                                                          .title),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        "NotoColorEmoji",
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  getSecondLetterOfFirstWord(
                                                      moodCtl
                                                          .listMood[indexMood]
                                                          .title
                                                          .tr),
                                                  style: GlobalTextStyles
                                                      .font12w400ColorBlack,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const SizedBox(),
                              Text(
                                journal.description,
                                style: GlobalTextStyles.font14w400Color889BCE,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }

  String getFirstLetterOfFirstWord(String input) {
    List<String> words = input.split(' ');
    return words[0];
  }

  String getSecondLetterOfFirstWord(String input) {
    List<String> words = input.split(' ');

    return " ${words[1]}";
  }

  List<int> convertListIndexMood(String strIndex) {
    if (strIndex.isNotEmpty) {
      List<int> intList = strIndex.split(',').map(int.parse).toList();
      return intList;
    } else {
      return [];
    }
  }

  int countMonthJounal(Map<String, List<Journal>> monthData) {
    int count = 0;
    monthData.forEach(
      (key, value) {
        count += value.length;
      },
    );
    return count;
  }
}
