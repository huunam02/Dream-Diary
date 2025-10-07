import '/config/global_color.dart';
import '/config/global_text_style.dart';
import 'package:flutter/material.dart';

class HourMinutePickerCustom extends StatefulWidget {
  const HourMinutePickerCustom(
      {super.key,
      required this.onChangeHour,
      required this.onChangeMinute,
      required this.defaultHour,
      required this.defaultMinute});
  final int defaultHour;
  final int defaultMinute;
  final ValueChanged<int> onChangeHour; // Callback cho giờ
  final ValueChanged<int> onChangeMinute; // Callback cho phút

  @override
  State<HourMinutePickerCustom> createState() => _HourMinutePickerCustomState();
}

class _HourMinutePickerCustomState extends State<HourMinutePickerCustom> {
  int hour = 0;
  int minute = 0;
  final int totalHours = 24;
  final int totalMinutes = 60;

  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  @override
  void initState() {
    super.initState();
    hour = widget.defaultHour % totalHours;
    minute = widget.defaultMinute % totalMinutes;
    // Khởi tạo các FixedExtentScrollController
    hourController = FixedExtentScrollController(initialItem: hour);
    minuteController = FixedExtentScrollController(initialItem: minute);
  }

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      alignment: Alignment.center,
      height: 312,
      width: 240,
      decoration: BoxDecoration(
        gradient: GlobalColors.linearContainer2,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNumberPicker(
                totalItems: totalHours,
                currentValue: hour,
                controller: hourController,
                onChanged: (value) {
                  setState(() {
                    hour = value % totalHours; // Cuộn vô tận cho giờ
                    widget.onChangeHour(hour);
                  });
                },
              ),
              _buildNumberPicker(
                totalItems: totalMinutes,
                currentValue: minute,
                controller: minuteController,
                onChanged: (value) {
                  setState(() {
                    minute = value % totalMinutes; // Cuộn vô tận cho phút
                    widget.onChangeMinute(minute);
                  });
                },
              ),
            ],
          ),
          // Đường viền ở giữa cho phần tử được chọn
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Colors.black.withOpacity(0.12), width: 1),
                  bottom: BorderSide(
                      color: Colors.black.withOpacity(0.12), width: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberPicker({
    required int totalItems,
    required int currentValue,
    required FixedExtentScrollController controller,
    required ValueChanged<int> onChanged,
  }) {
    return SizedBox(
      width: 80,
      height: 312,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 60,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            final displayValue =
                index % totalItems; // Hiển thị giá trị cuộn vô tận
            final isSelected = displayValue == currentValue;
            final isAdjacent = displayValue ==
                    (currentValue + 1) % totalItems ||
                displayValue == (currentValue - 1 + totalItems) % totalItems;

            TextStyle style = isSelected
                ? GlobalTextStyles.font24w700ColorBlack
                : isAdjacent
                    ? GlobalTextStyles
                        .font24w400ColorBlackOp80 // Màu cho giá trị gần
                    : GlobalTextStyles.font24w400ColorBlackOp24;

            return Center(
              child: Text(
                displayValue.toString().padLeft(2, '0'),
                style: style,
              ),
            );
          },
          // Đặt số lượng phần tử thật lớn để tạo cảm giác vô tận
          childCount: totalItems * 1000,
        ),
      ),
    );
  }
}
