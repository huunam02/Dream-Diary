import 'package:flutter/material.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 42.0,
        ),
        Expanded(
          child: Container(
            height: 0.5,
            color: Colors.black.withOpacity(0.12),
          ),
        ),
      ],
    );
  }
}
