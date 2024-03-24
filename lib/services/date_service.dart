import 'package:jiffy/jiffy.dart';

class DateService {
  static String humanReadableDateTime(DateTime selectedDate) {
    late String dayMonthPattern;
    var today = DateTime.now();
    if (selectedDate.day == today.day &&
        selectedDate.month == today.month &&
        selectedDate.year == today.year) {
      dayMonthPattern = "[Hoje]";
    } else if (selectedDate.day == today.day - 1 &&
        selectedDate.month == today.month &&
        selectedDate.year == today.year) {
      dayMonthPattern = "[Ontem]";
    } else if (selectedDate.day == today.day + 1 &&
        selectedDate.month == today.month &&
        selectedDate.year == today.year) {
      dayMonthPattern = "[Amanhã]";
    } else if (selectedDate.day == today.day - 2 &&
        selectedDate.month == today.month &&
        selectedDate.year == today.year) {
      dayMonthPattern = "[Anteontem]";
    } else if (selectedDate.year == today.year) {
      dayMonthPattern = "dd/MM";
    } else {
      dayMonthPattern = "dd/MM/yyyy";
    }
    return Jiffy.parseFromDateTime(selectedDate)
        .format(pattern: "$dayMonthPattern [às] HH:mm");
  }

  static String humanReadableDate(
    DateTime selectedDate, {
    bool showLaterYears = false,
    String customPattern = "dd/MM/yyyy",
    String customDayMonthPattern = "dd/MM",
  }) {
    late String dayMonthPattern;
    var today = DateTime.now();
    print("aaa");
    if (selectedDate.day == today.day &&
        selectedDate.month == today.month &&
        selectedDate.year == today.year) {
      dayMonthPattern = "[Hoje]";
    } else if (selectedDate.day == today.day - 1 &&
        selectedDate.month == today.month &&
        selectedDate.year == today.year) {
      dayMonthPattern = "[Ontem]";
    } else if (selectedDate.day == today.day + 1 &&
        selectedDate.month == today.month &&
        selectedDate.year == today.year) {
      dayMonthPattern = "[Amanhã]";
    } else if (selectedDate.day == today.day - 2 &&
        selectedDate.month == today.month &&
        selectedDate.year == today.year) {
      dayMonthPattern = "[Anteontem]";
    } else if (selectedDate.year == today.year && showLaterYears) {
      print("aqui");
      dayMonthPattern = customPattern;
    } else {
      dayMonthPattern = customDayMonthPattern;
    }
    return Jiffy.parseFromDateTime(selectedDate)
        .format(pattern: dayMonthPattern);
  }
}
