import '/config/global_text_style.dart';
import 'package:flutter/material.dart';

class ItemPageviewOnboarding extends StatefulWidget {
  const ItemPageviewOnboarding(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.description});
  final String imagePath;
  final String title;
  final String description;

  @override
  State<ItemPageviewOnboarding> createState() => _ItemPageviewOnboardingState();
}

class _ItemPageviewOnboardingState extends State<ItemPageviewOnboarding> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AspectRatio(
            aspectRatio: 360 / 440,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Image.asset(
                widget.imagePath,
                width: double.infinity,
           
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.title,
            style: GlobalTextStyles.font18w700ColorBlack,
          ),
          const SizedBox(height: 12),
          Text(
            textAlign: TextAlign.center,
            widget.description,
            style: GlobalTextStyles.font14w400ColorBlack,
          ),
        ],
      ),
    );
  }
}
