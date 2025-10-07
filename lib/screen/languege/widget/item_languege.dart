import '/config/global_color.dart';
import '/config/global_text_style.dart';
import 'package:flutter/material.dart';

class ItemLanguege extends StatelessWidget {
  final String language;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;
  const ItemLanguege(
      {super.key,
      required this.language,
      required this.imagePath,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: isSelected
              ? GlobalColors.linearPrimary2
              : GlobalColors.linearContainer2,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: ListTile(
          onTap: onTap,
          leading: Image.asset(
            imagePath,
            width: 24,
            height: 24,
          ),
          title: Text(
            language,
            style: isSelected
                ? GlobalTextStyles.font16w600ColorBlack
                : GlobalTextStyles.font14w400ColorBlack,
          ),
        ),
      ),
    );
  }
}
