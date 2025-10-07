import 'package:flutter/material.dart';

class BodyCustom extends StatelessWidget {
  const BodyCustom(
      {super.key,
      required this.child,
      this.edgeInsetsPadding,
      required this.isShowBgImages});
  final Widget child;
  final EdgeInsets? edgeInsetsPadding;
  final bool isShowBgImages;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: edgeInsetsPadding,
        height: double.infinity,
        width: double.infinity,
        decoration: isShowBgImages ? const BoxDecoration() : null,
        child: SafeArea(child: child));
  }
}
