import 'package:dream_diary/widget/image_base.dart';

import '/config/global_text_style.dart';
import '/model/dream.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDreamCustom extends StatelessWidget {
  const ItemDreamCustom({super.key, required this.dream});
  final Dream dream;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImageNetworkBase(
            dream.image156x156,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              height: w * 0.1,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color(0xBF29375A),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0))),
              child: Text(
                dream.title.tr,
                style: GlobalTextStyles.font14w400ColorBlack,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
