import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiapetsTimePickerController extends GetxController {
  final Rx<TimeOfDay> selectedTime = Rx<TimeOfDay>(TimeOfDay.now());
  final TextEditingController textEditingController = TextEditingController();

  DiapetsTimePickerController() {
    init();
  }

  void init() {
    textEditingController.text = selectedTimeFormatted;
    selectedTime.listen((TimeOfDay? date) {
      date ??= TimeOfDay.now();

      textEditingController.text = selectedTimeFormatted;
    });
  }

  String get selectedTimeFormatted {
    String hourString = selectedTime.value.hour.toString().padLeft(2, '0');
    String minuteString = selectedTime.value.minute.toString().padLeft(2, '0');
    return "$hourString:$minuteString";
  }
}
