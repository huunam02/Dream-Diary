import '/config/global_color.dart';
import '/config/global_text_style.dart';
import '/lang/l.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

CalendarDatePicker2WithActionButtonsConfig configCalendar(
    BuildContext context) {
  var dayTextStyle = GlobalTextStyles.font12w400ColorF1F2FF;
  DateTime currentDate = DateTime.now();
  CalendarDatePicker2WithActionButtonsConfig config =
      CalendarDatePicker2WithActionButtonsConfig(
    firstDate: DateTime.utc(2000, 1, 1),
    lastDate: DateTime.utc(currentDate.year, currentDate.month,
        DateUtils.getDaysInMonth(currentDate.year, currentDate.month)),
    buttonPadding: const EdgeInsets.fromLTRB(8.0, 0, 8, 16),
    okButton: Container(
      margin: const EdgeInsets.only(right: 8.0),
      alignment: Alignment.center,
      height: 34.0,
      width: 79.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: GlobalColors.linearPrimary2,
      ),
      child: Text(
        L.ok.tr,
        style: GlobalTextStyles.font12w600ColorBlack,
      ),
    ),
    cancelButtonTextStyle: GlobalTextStyles.font12w400ColorF1F2FF,
    weekdayLabels: [
      L.sun.tr,
      L.mon.tr,
      L.tue.tr,
      L.wed.tr,
      L.thu.tr,
      L.fri.tr,
      L.sat.tr
    ],
    calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
    dayTextStyle: dayTextStyle,
    calendarType: CalendarDatePicker2Type.single,
    selectedDayHighlightColor: Colors.purple[800],
    closeDialogOnCancelTapped: true,
    nextMonthIcon: SvgPicture.asset("assets/icons/ic_journal_next_month.svg",
        color: Colors.black),
    lastMonthIcon: SvgPicture.asset("assets/icons/ic_journal_last_month.svg",
        color: Colors.black),
    firstDayOfWeek: 1,
    weekdayLabelTextStyle: GlobalTextStyles.font12w400ColorBlack,
    controlsTextStyle: GlobalTextStyles.font14w600ColorBlack,
    customModePickerIcon: const SizedBox(),
    disableModePicker: true,
    modePickersGap: 0.0,
    hideYearPickerDividers: true,
    selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.black),
    dayTextStylePredicate: ({required date}) {
      TextStyle? textStyle;
      if (date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday) {
        return textStyle;
      }
      return null;
    },
    dayBuilder: (
        {required date,
        decoration,
        isDisabled,
        isSelected,
        isToday,
        textStyle}) {
      return Container(
        height: 32,
        width: 28.57,
        decoration: isSelected == true
            ? BoxDecoration(
                gradient: GlobalColors.linearPrimary2,
                borderRadius: BorderRadius.circular(8.0))
            : null,
        child: Center(
          child: Text(
            MaterialLocalizations.of(context).formatDecimal(date.day),
            style: isSelected == true
                ? GlobalTextStyles.font12w600ColorBlack
                : date.isBefore(currentDate)
                    ? textStyle
                    : GlobalTextStyles.font12w400ColorBlackOp30,
          ),
        ),
      );
    },
  );

  return config;
}
