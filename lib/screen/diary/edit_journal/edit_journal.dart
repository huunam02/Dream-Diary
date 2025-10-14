import 'dart:io';

import '/config/global_color.dart';
import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/model/journal.dart';
import '../choice_mood/controller/mood_controller.dart';
import '../choice_mood/mood.dart';
import '../create_diary/widget/date_picker.dart';
import '../diary/controller/journal_controller.dart';
import '../diary/widget/mood_item.dart';
import '/screen/permission/controller/permission_controller.dart';
import '/util/format_date.dart';
import '/util/view_ex.dart';
import '/widget/audio_play_custom.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class EditJournalScreen extends StatefulWidget {
  const EditJournalScreen({super.key, required this.journal});
  final Journal journal;

  @override
  State<EditJournalScreen> createState() => _EditJournalScreenState();
}

class _EditJournalScreenState extends State<EditJournalScreen> {
  DateTime _selectedDate = DateTime.now();
  final moodCtl = Get.find<MoodController>();
  final journalCtl = Get.find<DiaryController>();
  final permisionCtl = Get.find<PermissionController>();
  bool isLoading = true;
  late Directory appDirectory;
  bool isRecorded = false;
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  String? _filePath;
  final titleController = TextEditingController();
  final desController = TextEditingController();
  bool isValidTitle = false;
  bool isValidAllData = false;
  bool isChangeRecod = false;

  String? fullFilePath;
  String? fullFilePathBase;

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    isLoading = false;
    setState(() {});
  }

  void _checkDataChange() {
    String listMoodSelectedIndex = moodCtl.listMoodSelected.join(',');
    if (titleController.text != widget.journal.title ||
        desController.text != widget.journal.description ||
        widget.journal.mood != listMoodSelectedIndex ||
        _selectedDate.toString() != widget.journal.date ||
        isChangeRecod) {
      setState(() {
        isValidAllData = true;
      });
    } else {
      setState(() {
        isValidAllData = false;
      });
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
                            saveJournal();
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

  Future<void> _startRecording() async {
    try {
      setState(() {
        isRecorded = false;
      });
      String formattedDate = FormatDate().formatDatePath(DateTime.now());
      fullFilePath = "${_filePath!}$formattedDate.aac";
      await _recorder!.startRecorder(
        toFile: fullFilePath,
        codec: Codec.aacADTS,
      );
      showDialogLoad();
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
      });
    } catch (e) {
      debugPrint("Error stopping recording: $e");
    }
  }

  List<int> convertListIndexMood(String strIndex) {
    if (strIndex.isNotEmpty) {
      List<int> intList = strIndex.split(',').map(int.parse).toList();
      return intList;
    } else {
      return [];
    }
  }

  void loadData() {
    _selectedDate = DateTime.parse(widget.journal.date);
    titleController.text = widget.journal.title;
    desController.text = widget.journal.description;
    fullFilePath = widget.journal.voicePath;
    moodCtl.listMoodSelected.value = convertListIndexMood(widget.journal.mood);
    fullFilePathBase = widget.journal.voicePath;
    for (int element in convertListIndexMood(widget.journal.mood)) {
      moodCtl.selectedMood(moodCtl.listMood[element]);
    }
    if (fullFilePath != "") {
      isRecorded = true;
    }
    setState(() {});
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
  void initState() {
    super.initState();
    _getDir();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    _openAudioSession();
    loadData();
  }

  @override
  void dispose() {
    _recorder?.closeRecorder();
    _player?.closePlayer();
    titleController.dispose();
    desController.dispose();
    super.dispose();
  }

// hihi
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
                    SizedBox(
                      height: 64.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (isValidTitle || isValidAllData) {
                                await showDialogSave();
                              }
                              moodCtl.clearData();
                              if (fullFilePathBase != fullFilePath) {
                                final file = File(fullFilePath!);
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
                              }
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
                                  dialogSize: const Size(264, 357),
                                  borderRadius: BorderRadius.circular(8),
                                  value: [_selectedDate],
                                  dialogBackgroundColor: GlobalColors
                                      .linearContainer2.colors.first);
                              if (value != null && value.isNotEmpty) {
                                setState(() {
                                  _selectedDate = value.first!;
                                });
                              }
                              _checkDataChange();
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
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              _validateInput(value);
                              _checkDataChange();
                            },
                            controller: titleController,
                            autofocus: false,
                            style: GlobalTextStyles.font14w600ColorBlack,
                            decoration: InputDecoration(
                                hintText: L.untitled.tr,
                                border: InputBorder.none,
                                hintStyle:
                                    GlobalTextStyles.font14w600ColorBlackOp60),
                          ),
                          isRecorded && fullFilePath != ""
                              ? AudioPlayCustom(
                                  width: MediaQuery.of(context).size.width / 2,
                                  appDirectory: appDirectory,
                                  path: fullFilePath,
                                  onTapDelete: () async {
                                    isChangeRecod = true;
                                    _checkDataChange();
                                    if (fullFilePath != fullFilePathBase) {
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
                                    } else {
                                      setState(() {
                                        fullFilePath = "";
                                        isRecorded = false;
                                      });
                                    }
                                  },
                                  isShowDelete: true,
                                )
                              : const SizedBox(),
                          TextField(
                            onChanged: (value) {
                              _checkDataChange();
                            },
                            controller: desController,
                            autofocus: false,
                            style: GlobalTextStyles.font14w400ColorBlack,
                            minLines: 6,
                            maxLines: 12,
                            decoration: InputDecoration(
                              hintStyle:
                                  GlobalTextStyles.font14w400ColorBlackOp38,
                              border: InputBorder.none,
                              hintText: L.writeSomething.tr,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.5, color: Color(0xFF2D3156)))),
                            height: 45.0,
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                permisionCtl.requestMicro();
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
                                    if (moodCtl.listMoodSelected.isEmpty) {
                                      moodCtl.listMoodSelected.value =
                                          convertListIndexMood(
                                              widget.journal.mood);
                                    }
                                    Get.to(() => const ChoiceMoodScreen())!
                                        .then(
                                      (value) {
                                        _checkDataChange();
                                      },
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/ic_journal_pen2.svg",
                                    // ignore: deprecated_member_use
                                    color: GlobalColors.primary2,
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
                          saveJournal();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 48.0,
                          width: w * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(39.0),
                              color: isValidTitle || isValidAllData
                                  ? null
                                  : GlobalColors.linearPrimary1.colors.first,
                              gradient: isValidTitle || isValidAllData
                                  ? GlobalColors.linearPrimary2
                                  : null),
                          child: Text(
                            L.save.tr,
                            style: isValidTitle || isValidAllData
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

  Future<void> saveJournal() async {
    if (isValidTitle || isValidAllData) {
      String listMoodSelectedIndex = moodCtl.listMoodSelected.join(',');
      if (fullFilePathBase != fullFilePath) {
        final file = File(fullFilePathBase!);
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
      }
      Journal journal = Journal(
          id: widget.journal.id,
          title: titleController.text,
          description: desController.text,
          date: _selectedDate.toString(),
          mood: listMoodSelectedIndex,
          voicePath: fullFilePath ?? "");

      journalCtl.editJournal(journal);
      moodCtl.clearData();
    }
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
                    Lottie.asset("assets/lotties/recording.json",
                        width: 250, height: 250, fit: BoxFit.cover),
                    GestureDetector(
                      onTap: () {
                        _stopRecording();
                        Get.back();
                        isChangeRecod = true;
                        _checkDataChange();
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
}
