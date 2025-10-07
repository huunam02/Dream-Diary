import '/config/global_color.dart';
import '/config/global_text_style.dart';
import '/model/mood.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomMoodItem2 extends StatelessWidget {
  const CustomMoodItem2({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      decoration: BoxDecoration(
        gradient: GlobalColors.linearPrimary2,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            getFirstLetterOfFirstWord(title),
            style: const TextStyle(
              fontSize: 12,
              fontFamily: "NotoColorEmoji",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            getSecondLetterOfFirstWord(title.tr),
            style: GlobalTextStyles.font12w400ColorBlack,
          ),
        ],
      ),
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
}

class CustomMoodItem1 extends StatefulWidget {
  const CustomMoodItem1({super.key, required this.mood});
  final Mood mood;

  @override
  State<CustomMoodItem1> createState() => _CustomMoodItem1State();
}

class _CustomMoodItem1State extends State<CustomMoodItem1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      decoration: widget.mood.isSelected
          ? BoxDecoration(
              gradient: GlobalColors.linearPrimary2,
              borderRadius: BorderRadius.circular(20.0),
            )
          : BoxDecoration(
              color: const Color(0xFF1A2138),
              borderRadius: BorderRadius.circular(20.0),
            ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            getFirstLetterOfFirstWord(widget.mood.title),
            style: const TextStyle(
              fontSize: 12,
              fontFamily: "NotoColorEmoji",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            getSecondLetterOfFirstWord(widget.mood.title.tr),
            style: GlobalTextStyles.font12w400ColorBlack,
          ),
        ],
      ),
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
}
