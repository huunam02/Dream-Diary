import 'dart:io';
import 'widget/modalbottomsheet_detete.dart';
import '../edit_diary/edit_diary.dart';
import '../diary/controller/journal_controller.dart';
import '../diary/widget/mood_item.dart';
import '/util/format_date.dart';
import '/config/global_text_style.dart';
import '/model/journal.dart';
import '../choice_mood/controller/mood_controller.dart';
import '/widget/audio_play_custom.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';


class DetailDiary extends StatefulWidget {
  const DetailDiary({super.key, required this.journal});
  final Journal journal;
  @override
  State<DetailDiary> createState() => _DetailDiaryState();
}

class _DetailDiaryState extends State<DetailDiary> {
  late Directory appDirectory;
  final moodCtl = Get.find<MoodController>();
  final journalCtl = Get.find<DiaryController>();
  bool isLoadDirectored = false;

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    setState(() {
      isLoadDirectored = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _getDir();
  }

  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BodyCustom(
          isShowBgImages: true,
          edgeInsetsPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 64.0,
                  child: Row(
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
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() =>
                                EditDiaryScreen(journal: widget.journal)),
                            child: SvgPicture.asset(
                              "assets/icons/ic_edit.svg",
                              width: 24.0,
                              height: 24.0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          GestureDetector(
                            onTap: () {
                  
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return ModalbottomsheetDeteteCustom(
                                    ontapDelete: () {
                         
                                      Get.back();
                                      journalCtl.deleteJournal(widget.journal);
                                    },
                                    ontapCancel: () {
                             
                                      Get.back();
                                    },
                                  );
                                },
                              );
                            },
                            child: SvgPicture.asset(
                              "assets/icons/ic_trash.svg",
                              width: 24.0,
                              height: 24.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  widget.journal.title,
                  style: GlobalTextStyles.font18w700ColorBlack,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Wrap(
                  runSpacing: 10.0,
                  spacing: 12.0,
                  children: List.generate(
                      convertListIndexMood(widget.journal.mood).length,
                      (index) {
                    int indexMood =
                        convertListIndexMood(widget.journal.mood)[index];
                    return CustomMoodItem2(
                        title: moodCtl.listMood[indexMood].title);
                  }),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/icons/ic_calendar.svg",
                        width: 24.0,
                        height: 24.0,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      FormatDate()
                          .formatDate2(DateTime.parse(widget.journal.date)),
                      style: GlobalTextStyles.font14w400ColorBlackOp60,
                    )
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                isLoadDirectored && widget.journal.voicePath != ""
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: AudioPlayCustom(
                          width: MediaQuery.of(context).size.width / 2,
                          appDirectory: appDirectory,
                          path: widget.journal.voicePath,
                          onTapDelete: () async {
                            final file = File(widget.journal.voicePath);
                            if (await file.exists()) {
                              try {
                                await file.delete();
                                debugPrint('File đã được xóa thành công');
                              } catch (e) {
                                debugPrint('Có lỗi khi xóa file: $e');
                              }
                            } else {
                              debugPrint('File không tồn tại');
                            }
                          },
                          isShowDelete: false,
                        ),
                      )
                    : const SizedBox(),
                Text(
                  widget.journal.description,
                  style: GlobalTextStyles.font14w600ColorBlack,
                )
              ],
            ),
          ),
        ));
  }

  List<int> convertListIndexMood(String strIndex) {
    if (strIndex.isNotEmpty) {
      List<int> intList = strIndex.split(',').map(int.parse).toList();
      return intList;
    } else {
      return [];
    }
  }
}
