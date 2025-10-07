
import '/util/format_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class RecordAudio {
  String? filePath;
  bool isLoading = true;
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  String? fullFilePath;

  Future<void> init() async {
    await openAudioSession();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
  }

  Future<void> checkPermissions() async {
    final microphoneStatus = await Permission.microphone.request();
    final storageStatus = await Permission.storage.request();

    if (!microphoneStatus.isGranted || !storageStatus.isGranted) {
      debugPrint("Microphone and Storage permissions are required");
    }
  }

  Future<void> loadFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    filePath = "${directory.path}/";
  }

  Future<void> openAudioSession() async {
    try {
      await _recorder!.openRecorder();
      await _player!.openPlayer();
      await checkPermissions();
      await loadFilePath();
    } catch (e) {
      debugPrint("Error opening audio session: $e");
    }
  }

  void startRecording(
      BuildContext context, VoidCallback onStart, VoidCallback onStop) async {
    try {
      String formattedDate = FormatDate().formatDatePath(DateTime.now());
      fullFilePath = "${filePath!}$formattedDate.aac";
      debugPrint(fullFilePath);
      onStart();
      await _recorder!.startRecorder(
        toFile: fullFilePath,
        codec: Codec.aacADTS,
      );
    } catch (e) {
      debugPrint("Error starting recording: $e");
    }
  }

  Future<void> stopRecording(VoidCallback onStop) async {
    debugPrint("Stopping Recoding");

    try {
      await _recorder!.stopRecorder();
      debugPrint("Record Susscess");
      onStop();
    } catch (e) {
      debugPrint("Error stopping recording: $e");
    }
  }

  void dispose() {
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
  }
}
