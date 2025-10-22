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
    return Container(
        alignment: Alignment.bottomCenter,
        width: w * 0.4,
        height: w * 0.4,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                dream.image156x156,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(16.0)),
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
        ));
  }
}
