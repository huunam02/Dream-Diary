import 'dart:async';
import 'dart:io';
import 'package:dream_diary/base/lifecycle_state.dart';

import '/config/global_color.dart';
import '/config/global_text_style.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AudioPlayCustom extends StatefulWidget {
  final String? path;
  final double? width;
  final Directory appDirectory;
  final GestureTapCallback onTapDelete;
  final bool isShowDelete;
  const AudioPlayCustom({
    super.key,
    required this.appDirectory,
    this.width,
    this.path,
    required this.onTapDelete,
    required this.isShowDelete,
  });

  @override
  State<AudioPlayCustom> createState() => _AudioPlayCustomState();
}

class _AudioPlayCustomState extends LifecycleState<AudioPlayCustom> {
  File? file;
  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;
  String maxTime = "00:00";
  String currentTime = "00:00";
  final playerWaveStyle = PlayerWaveStyle(
      fixedWaveColor: const Color(0xFFC4C4C4).withOpacity(0.12),
      liveWaveColor: const Color(0xFF3076C9),
      spacing: 6,
      showSeekLine: false);

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
  }

  void _preparePlayer() async {
    controller.preparePlayer(
      path: widget.path ?? "",
      shouldExtractWaveform: true,
    );

    controller
        .extractWaveformData(
          path: widget.path ?? "",
          noOfSamples: playerWaveStyle.getSamplesForWidth(widget.width ?? 200),
        )
        .then((waveformData) => debugPrint(waveformData.toString()));
  }

  String formatDuration(int event) {
    double val = event / 1000;
    int duration = val.round();

    int minutes = duration ~/ 60;
    int remainingSeconds = duration % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return widget.path != null || file?.path != null
        ? Container(
            height: 72.0,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: const Color(0xFF1D273E),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!controller.playerState.isStopped)
                  GestureDetector(
                    onTap: () async {
                      controller.playerState.isPlaying
                          ? await controller.pausePlayer()
                          : await controller.startPlayer();
                      controller.onCurrentDurationChanged.listen(
                        (event) async {
                          setState(() {
                            currentTime = formatDuration(event);
                          });
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 48.0,
                      width: 48.0,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(50)),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: GlobalColors.linearPrimary2,
                        ),
                        child: controller.playerState.isPlaying
                            ? const Icon(
                                Icons.stop,
                                color: Colors.black,
                                size: 15.0,
                              )
                            : SvgPicture.asset(
                                "assets/icons/ic_journal_play.svg",
                                width: 13.59,
                                height: 14.46,
                              ),
                      ),
                    ),
                  ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AudioFileWaveforms(
                        size: Size(w * 0.7, 22),
                        playerController: controller,
                        waveformType: WaveformType.long,
                        playerWaveStyle: playerWaveStyle,
                        continuousWaveform: false,
                        enableSeekGesture: true,
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentTime,
                              style: GlobalTextStyles.font12w400ColorBlack,
                            ),
                            Text(formatDuration(controller.maxDuration),
                                style:
                                    GlobalTextStyles.font12w400ColorBlack)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                widget.isShowDelete
                    ? GestureDetector(
                        onTap: widget.onTapDelete,
                        child: SvgPicture.asset(
                            "assets/icons/ic_journal_delete.svg"))
                    : const SizedBox()
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {
    controller.pausePlayer();
  }

  @override
  void onResumed() {}

  @override
  void onKeyboardHint() {}

  @override
  void onKeyboardShow() {}
}
