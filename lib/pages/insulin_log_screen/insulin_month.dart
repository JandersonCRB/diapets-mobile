import 'package:diapets_mobile/models/insulin_application.dart';
import 'package:diapets_mobile/pages/insulin_log_screen/insulin_day.dart';
import 'package:diapets_mobile/services/date_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import 'insulin_log_controller.dart';

class InsulinMonth extends StatelessWidget {
  final String monthKey;
  final List<String> days;
  late final String monthName;
  InsulinMonth({
    super.key,
    required this.monthKey,
    required this.days,
  }) {
    var jiffyDate = Jiffy.parse(monthKey, pattern: 'yyyy-MM');
    monthName = jiffyDate.format(pattern: 'MMMM yyyy');
  }

  @override
  Widget build(BuildContext context) {
    InsulinLogController insulinLogController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            monthName.capitalizeFirst!,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: days.length,
          itemBuilder: (context, index) {
            String dayKey = days[index];
            List<InsulinApplication> insulinApplications =
                insulinLogController.dayMap[dayKey]!;
            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      DateService.humanReadableDate(
                              DateFormat("MM-dd").parse(dayKey),
                              customDayMonthPattern: "dd MMM")
                          .split(" ")
                          .map((e) => e.capitalizeFirst!)
                          .join(" "),
                      style: const TextStyle(
                        color: Color(0xFF888D92),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Color(0xFF494F59),
                        indent: 8,
                        endIndent: 8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                InsulinDay(insulinApplications: insulinApplications),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ],
    );
  }
}
