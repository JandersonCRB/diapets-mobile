import 'package:diapets_mobile/models/insulin_application.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class InsulinDay extends StatelessWidget {
  final List<InsulinApplication> insulinApplications;
  const InsulinDay({
    super.key,
    required this.insulinApplications,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...insulinApplications.map(
          (insulinApplication) => InsulinCard(
            insulinApplication: insulinApplication,
          ),
        ),
      ],
    );
  }
}

class InsulinCard extends StatelessWidget {
  final InsulinApplication insulinApplication;

  const InsulinCard({
    super.key,
    required this.insulinApplication,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF2E3641),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  insulinApplication.user!.firstName!,
                  style: const TextStyle(
                    color: Color(0xFF9B6BF3),
                  ),
                ),
                Text(
                  Jiffy.parseFromDateTime(insulinApplication.applicationTime!)
                      .Hm,
                  style: const TextStyle(
                    color: Color(0xFF888D92),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "${insulinApplication.insulinUnits!} unidades | ${insulinApplication.glucoseLevel} glicose",
              style: const TextStyle(
                color: Color(0xFF888D92),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
