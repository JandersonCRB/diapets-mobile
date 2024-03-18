import 'package:diapets_mobile/components/loading_switch/loading_switch.dart';
import 'package:diapets_mobile/pages/insulin_log_screen/insulin_log_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'insulin_month.dart';

class InsulinLogContent extends StatelessWidget {
  const InsulinLogContent({super.key});

  @override
  Widget build(BuildContext context) {
    InsulinLogController insulinLogController = Get.find();
    return Obx(
      () => LoadingSwitch(
        isLoading: insulinLogController.loading.value,
        child: insulinLogController.monthList.isEmpty
            ? const Center(
                child: Text('Nenhum registro de insulina'),
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: insulinLogController.monthList.length,
                  itemBuilder: (context, index) {
                    String monthKey = insulinLogController.monthList[index];
                    List<String> days =
                        insulinLogController.monthMap[monthKey]!;
                    return InsulinMonth(
                      monthKey: monthKey,
                      days: days,
                    );
                  },
                ),
              ),
      ),
    );
  }
}
