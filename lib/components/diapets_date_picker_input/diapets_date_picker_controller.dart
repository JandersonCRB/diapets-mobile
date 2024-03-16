import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class DiapetsDatePickerController extends GetxController {
  final Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  final TextEditingController textEditingController = TextEditingController();

  void init() {
    print("inited");
    textEditingController.text = selectedDateFormatted;
    selectedDate.listen((DateTime? date) {
      date ??= DateTime.now();

      textEditingController.text = selectedDateFormatted;
    });
  }

  String get selectedDateFormatted {
    late String dayMonthPattern;
    var today = DateTime.now();
    if (selectedDate.value.day == today.day &&
        selectedDate.value.month == today.month &&
        selectedDate.value.year == today.year) {
      dayMonthPattern = "[Hoje]";
    } else if (selectedDate.value.day == today.day - 1 &&
        selectedDate.value.month == today.month &&
        selectedDate.value.year == today.year) {
      dayMonthPattern = "[Ontem]";
    } else if (selectedDate.value.day == today.day + 1 &&
        selectedDate.value.month == today.month &&
        selectedDate.value.year == today.year) {
      dayMonthPattern = "[Amanhã]";
    } else if (selectedDate.value.day == today.day - 2 &&
        selectedDate.value.month == today.month &&
        selectedDate.value.year == today.year) {
      dayMonthPattern = "[Anteontem]";
    } else if (selectedDate.value.year == today.year) {
      dayMonthPattern = "dd/MM";
    } else {
      dayMonthPattern = "dd/MM/yyyy";
    }
    return Jiffy.parseFromDateTime(selectedDate.value)
        .format(pattern: "$dayMonthPattern [às] HH:mm");
  }

  DiapetsDatePickerController() {
    init();
  }
}
