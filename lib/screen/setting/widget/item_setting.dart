import '/config/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemSettingCustom extends StatelessWidget {
  const ItemSettingCustom(
      {super.key,
      required this.icon,
      required this.title,
      required this.ontap});
  final String icon;
  final String title;
  final GestureTapCallback ontap;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: h * 0.05,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      icon,
                      height: 20.0,
                      width: 20.0,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      title,
                      style: GlobalTextStyles.font14w600ColorBlack,
                    ),
                  ],
                ),
                SvgPicture.asset(
                  "assets/icons/ic_arrow_right.svg",
                  height: 20.0,
                  width: 20.0,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
