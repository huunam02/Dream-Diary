import '/config/global_color.dart';
import '/config/global_text_style.dart';
import '/lang/l.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ModalbottomsheetDeteteCustom extends StatelessWidget {
  const ModalbottomsheetDeteteCustom(
      {super.key, required this.ontapDelete, required this.ontapCancel});
  final GestureTapCallback ontapDelete;
  final GestureTapCallback ontapCancel;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 16.0),
      height: h * 0.3,
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(23.0), topRight: Radius.circular(23.0)),
        gradient: GlobalColors.linearContainer2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: SvgPicture.asset("assets/icons/ic_gach.svg"),
          ),
          Text(
            L.deleteJournal.tr,
            style: GlobalTextStyles.font16w600ColorBlack,
          ),
          Text(
            L.doYouWantDelete.tr,
            style: GlobalTextStyles.font14w400ColorBlack,
          ),
          const SizedBox(
            height: 8.0,
          ),
          MaterialButton(
            height: h * 0.06,
            minWidth: double.infinity,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            color: const Color(0xFFF1205F),
            onPressed: ontapDelete,
            child: Text(
              L.delete.tr,
              style: GlobalTextStyles.font14w600ColorBlack,
            ),
          ),
          GestureDetector(
            onTap: ontapCancel,
            child: Container(
              alignment: Alignment.center,
              height: h * 0.06,
              width: double.infinity,
              child: Text(
                L.cancel.tr,
                style: GlobalTextStyles.font14w400ColorBlack,
              ),
            ),
          )
        ],
      ),
    );
  }
}
