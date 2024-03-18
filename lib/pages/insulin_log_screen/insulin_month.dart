import 'package:diapets_mobile/models/insulin_application.dart';
import 'package:diapets_mobile/pages/insulin_log_screen/insulin_day.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:timelines/timelines.dart';

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
            return MonthTimelineTile(
              insulinApplications: insulinApplications,
              dayKey: dayKey,
            );
          },
        ),
      ],
    );
  }
}

class MonthTimelineTile extends StatelessWidget {
  final String dayKey;
  final List<InsulinApplication> insulinApplications;
  const MonthTimelineTile({
    super.key,
    required this.insulinApplications,
    required this.dayKey,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      nodePosition: 0.17,
      oppositeContents: Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          dayKey.split('-').map((e) => e.padLeft(2, '0')).join('/'),
          style: const TextStyle(
            color: Color(0xFF888D92),
          ),
        ),
      ),
      contents: Padding(
        padding: const EdgeInsets.all(8),
        child: InsulinDay(insulinApplications: insulinApplications),
      ),
      node: const TimelineNode(
        indicator: DotIndicator(
          color: Color(0xFF494F59),
          size: 12,
        ),
        startConnector: SolidLineConnector(
          color: Color(0xFF494F59),
        ),
        endConnector: SolidLineConnector(
          color: Color(0xFF494F59),
        ),
      ),
    );
  }
}
