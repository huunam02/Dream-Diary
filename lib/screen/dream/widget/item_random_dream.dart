import '/config/global_text_style.dart';
import '/model/dream.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemRandomDreamCustom extends StatelessWidget {
  const ItemRandomDreamCustom({super.key, required this.dream});
  final Dream dream;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.only(right: 16.0),
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 120.0,
            height: 120.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                dream.image120x120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              dream.title.tr,
              style: GlobalTextStyles.font12w400ColorBlack,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
