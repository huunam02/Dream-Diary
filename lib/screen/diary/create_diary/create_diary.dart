import 'dart:io';
import 'package:dream_diary/screen/permission/controller/permission_controller.dart';

import '/config/global_color.dart';
import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/model/journal.dart';
import '../choice_mood/controller/mood_controller.dart';
import '../choice_mood/mood.dart';
import 'widget/date_picker.dart';
import '../diary/controller/journal_controller.dart';
import '../diary/widget/mood_item.dart';
import '/util/format_date.dart';
import '/util/view_ex.dart';
import '/widget/audio_play_custom.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateDiaryScreen extends StatefulWidget {
  const CreateDiaryScreen({super.key});

  @override
  State<CreateDiaryScreen> createState() => _CreateDiaryScreenState();
}

class _CreateDiaryScreenState extends State<CreateDiaryScreen> {
  DateTime _selectedDate = DateTime.now();
  final moodCtl = Get.find<MoodController>();
  final journalCtl = Get.find<DiaryController>();
  bool isLoading = true;
  late Directory appDirectory;
  bool isRecorded = false;
  bool isRecordedBefore = false;
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  String? _filePath;
  final titleController = TextEditingController();
  final desController = TextEditingController();
  bool isValidTitle = false;
  String? fullFilePath;
  final permissionCtl = Get.find<PermissionController>();
  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    isLoading = false;
    setState(() {});
  }

  Future<void> _checkPermissions() async {
    var status1 = await Permission.microphone.request();
    var status2 = await Permission.storage.request();
    var status3 = await Permission.photos.request();

    if (status1.isDenied || status2.isDenied || status3.isDenied) {
      print("Don't have pemission");
    }
  }

  Future<void> _loadFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    _filePath = "${directory.path}/";
  }

  Future<void> _openAudioSession() async {
    try {
      await _recorder!.openRecorder();
      await _player!.openPlayer();
      await _checkPermissions();
      await _loadFilePath();
    } catch (e) {
      debugPrint("Error opening audio session: $e");
    }
  }

  Future<void> showDialogSave() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                  gradient: GlobalColors.linearContainer2,
                  borderRadius: BorderRadius.circular(8.0)),
              height: 188.0,
              width: 280.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    L.notSaveYet.tr,
                    style: GlobalTextStyles.font14w600ColorBlack,
                  ),
                  Text(
                    L.doYouWantKeepSave.tr,
                    style: GlobalTextStyles.font14w400ColorBlackOp60,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          tapAndCheckInternet(() {
                            Get.back();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0)),
                          alignment: Alignment.center,
                          height: 34,
                          width: 88,
                          child: Text(
                            L.cancel.tr,
                            style: GlobalTextStyles.font12w400ColorBlack,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          tapAndCheckInternet(() {
                            Get.back();
                            String listMoodSelectedIndex =
                                moodCtl.listMoodSelected.join(',');
                            Journal journal = Journal(
                                title: titleController.text,
                                description: desController.text,
                                date: _selectedDate.toString(),
                                mood: listMoodSelectedIndex,
                                voicePath: fullFilePath ?? "");
                            journalCtl.insertJournal(journal);
                            moodCtl.clearData();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: GlobalColors.linearPrimary2,
                              borderRadius: BorderRadius.circular(4.0)),
                          alignment: Alignment.center,
                          height: 34,
                          width: 88,
                          child: Text(
                            L.ok.tr,
                            style: GlobalTextStyles.font14w600ColorBlack,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
        );
      },
    );
  }

  void showDialogLoad() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              return;
            }
          },
          child: Dialog(
            backgroundColor: GlobalColors.linearContainer2.colors.first,
            child: SizedBox(
                height: 350,
                width: 350,
                child: Column(
                  children: [
                    Lottie.asset(
                      "assets/lotties/recording.json",
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    GestureDetector(
                      onTap: () {
                        _stopRecording();
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: GlobalColors.linearPrimary2,
                            borderRadius: BorderRadius.circular(12.0)),
                        alignment: Alignment.center,
                        height: 60,
                        width: 100,
                        child: Text(
                          L.stop.tr,
                          style: GlobalTextStyles.font14w600ColorBlack,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  Future<void> _startRecording() async {
    try {
      String formattedDate = FormatDate().formatDatePath(DateTime.now());
      fullFilePath = "${_filePath!}$formattedDate.aac";
      debugPrint(fullFilePath);
      await _recorder!.startRecorder(
        toFile: fullFilePath,
        codec: Codec.aacADTS,
      );
      showDialogLoad();
      setState(() {
        isRecorded = false;
      });
    } catch (e) {
      debugPrint("Error starting recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    debugPrint("Stopping Recoding");

    try {
      await _recorder!.stopRecorder();
      debugPrint("Record Susscess");
      setState(() {
        isRecorded = true;
        if (desController.text.isEmpty) {
          isRecordedBefore = true;
        } else {
          isRecordedBefore = false;
        }
      });
    } catch (e) {
      debugPrint("Error stopping recording: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getDir();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    _openAudioSession();
  }

  @override
  void dispose() {
    _recorder?.closeRecorder();
    _player?.closePlayer();
    super.dispose();
  }

  void _validateInput(String value) {
    String trimmedValue = value.replaceAll(' ', ''); // Loại bỏ khoảng trắng
    if (trimmedValue.isEmpty) {
      setState(() {
        isValidTitle = false;
      });
    } else if (value.length > 100) {
      setState(() {
        isValidTitle = false;
      });
    } else {
      setState(() {
        isValidTitle = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BodyCustom(
          isShowBgImages: true,
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Container(
                      height: 64.0,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (isValidTitle) {
                                await showDialogSave();
                              }
                              moodCtl.clearData();
                            },
                            child: SvgPicture.asset(
                              "assets/icons/ic_journal_back.svg",
                              width: 24.0,
                              height: 24.0,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              var value = await showCalendarDatePicker2Dialog(
                                  barrierDismissible: true,
                                  context: context,
                                  config: configCalendar(context),
                                  dialogSize: const Size(290.0, 380.0),
                                  borderRadius: BorderRadius.circular(8),
                                  value: [_selectedDate],
                                  dialogBackgroundColor:
                                      const Color(0xFF1D273E));
                              if (value != null && value.isNotEmpty) {
                                setState(() {
                                  _selectedDate = value.first!;
                                });
                              }
                            },
                            child: Row(
                              children: [
                                Text(
                                  FormatDate().formatDate1(_selectedDate),
                                  style: GlobalTextStyles.font18w700ColorBlack,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                SvgPicture.asset(
                                  "assets/icons/ic_journal_arrow_down.svg",
                                  width: 18.0,
                                  height: 18.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24.0, width: 24.0),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              _validateInput(value);
                            },
                            maxLength: 100,
                            controller: titleController,
                            autofocus: false,
                            style: GlobalTextStyles.font14w600ColorBlack,
                            decoration: InputDecoration(
                                hintText: L.untitled.tr,
                                border: InputBorder.none,
                                hintStyle:
                                    GlobalTextStyles.font14w600ColorBlackOp60,
                                counterText: ""),
                          ),
                          isRecorded && isRecordedBefore
                              ? AudioPlayCustom(
                                  width: MediaQuery.of(context).size.width / 2,
                                  appDirectory: appDirectory,
                                  path: fullFilePath,
                                  onTapDelete: () async {
                                    final file = File(fullFilePath!);
                                    if (await file.exists()) {
                                      try {
                                        await file.delete();
                                        debugPrint(
                                            'File đã được xóa thành công');
                                        setState(() {
                                          isRecorded = false;
                                        });
                                      } catch (e) {
                                        debugPrint('Có lỗi khi xóa file: $e');
                                      }
                                    } else {
                                      debugPrint('File không tồn tại');
                                    }
                                  },
                                  isShowDelete: true,
                                )
                              : const SizedBox(),
                          TextField(
                            maxLength: 600,
                            controller: desController,
                            autofocus: false,
                            style: GlobalTextStyles.font14w400ColorBlack,
                            minLines: 6,
                            maxLines: 12,
                            decoration: InputDecoration(
                              counterText: "",
                              hintStyle:
                                  GlobalTextStyles.font14w400ColorBlackOp38,
                              border: InputBorder.none,
                              hintText: L.writeSomething.tr,
                            ),
                          ),
                          isRecorded && isRecordedBefore == false
                              ? Container(
                                  margin: const EdgeInsets.only(bottom: 8.0),
                                  child: AudioPlayCustom(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    appDirectory: appDirectory,
                                    path: fullFilePath,
                                    onTapDelete: () async {
                                      final file = File(fullFilePath!);
                                      if (await file.exists()) {
                                        try {
                                          await file.delete();
                                          debugPrint(
                                              'File đã được xóa thành công');
                                          setState(() {
                                            isRecorded = false;
                                          });
                                        } catch (e) {
                                          debugPrint('Có lỗi khi xóa file: $e');
                                        }
                                      } else {
                                        debugPrint('File không tồn tại');
                                      }
                                    },
                                    isShowDelete: true,
                                  ),
                                )
                              : const SizedBox(),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.5, color: Color(0xFF2D3156)))),
                            height: 45.0,
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                permissionCtl.requestMicro();
                                _startRecording();
                              },
                              child: SvgPicture.asset(
                                "assets/icons/ic_journal_micro.svg",
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 24.0,
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(L.moods.tr,
                                    style: GlobalTextStyles
                                        .font14w600ColorBlackOp60),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const ChoiceMoodScreen());
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/ic_journal_pen2.svg",
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
                              child: SingleChildScrollView(
                            child: Obx(
                              () => Wrap(
                                runSpacing: 10.0,
                                spacing: 12.0,
                                children: List.generate(
                                    moodCtl.listMoodSelected.length, (index) {
                                  return CustomMoodItem2(
                                      title: moodCtl
                                          .listMood[
                                              moodCtl.listMoodSelected[index]]
                                          .title);
                                }),
                              ),
                            ),
                          ))
                        ],
                      ),
                    )),
                    Container(
                      height: 80.0,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: GlobalColors.linearContainer2,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (isValidTitle) {
                            tapAndCheckInternet(() {
                              String listMoodSelectedIndex =
                                  moodCtl.listMoodSelected.join(',');
                              Journal journal = Journal(
                                  title: titleController.text,
                                  description: desController.text,
                                  date: _selectedDate.toString(),
                                  mood: listMoodSelectedIndex,
                                  voicePath: fullFilePath ?? "");
                              journalCtl.insertJournal(journal);
                              moodCtl.clearData();
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 48.0,
                          width: w * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(39.0),
                              gradient: isValidTitle
                                  ? GlobalColors.linearPrimary2
                                  : null,
                              color: isValidTitle
                                  ? null
                                  : GlobalColors.linearPrimary1.colors.first,),
                          child: Text(
                            L.save.tr,
                            style: isValidTitle
                                ? GlobalTextStyles.font14w600ColorBlack
                                : GlobalTextStyles.font14w600ColorBlackOp38,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ));
  }
}
