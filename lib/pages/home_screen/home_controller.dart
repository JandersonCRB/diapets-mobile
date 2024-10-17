import 'dart:async';

import 'package:diapets_mobile/models/insulin_application.dart';
import 'package:diapets_mobile/services/api.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var loading = true.obs;
  var onTime = true.obs;
  Rxn<DateTime> nextInsulin = Rxn<DateTime>();
  var timeLeft = '00:00:00'.obs;
  late Rx<int> petId;

  Rxn<InsulinApplication> lastInsulinApplication = Rxn<InsulinApplication>();

  Timer? nextInsulinTimer;
  Timer? autoUpdateTimer;

  Future<void> init(int petId) async {
    this.petId = petId.obs;
    await updateData(petId);
    startCalculationInterval();
    startAutoUpdate();
  }

  updateData(int petId, {bool triggerLoading = true}) async {
    if (triggerLoading) {
      loading.value = true;
    }
    Api api = Get.find();
    var response = await api.dio.get('/api/v1/pets/$petId/dashboard');
    if (response.data['next_insulin_application'] != null) {
      nextInsulin.value = DateFormat("yyyy-MM-ddTHH:mm:ss")
          .parse(response.data['next_insulin_application'], true)
          .toLocal();
    }

    if (response.data['last_insulin_application'] != null) {
      lastInsulinApplication.value = InsulinApplication.fromJson(
        response.data['last_insulin_application'],
      );
    }

    loading.value = false;
  }

  startAutoUpdate() {
    autoUpdateTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      updateData(petId.value, triggerLoading: false);
    });
  }

  void startCalculationInterval() {
    nextInsulinTimer?.cancel();
    recalculateNextInsulin();
    nextInsulinTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      recalculateNextInsulin();
    });
  }

  void recalculateNextInsulin() {
    if (nextInsulin.value!.isBefore(DateTime.now())) {
      onTime.value = false;
    } else {
      onTime.value = true;
    }

    var timeDiff = nextInsulin.value?.difference(DateTime.now());
    timeLeft.value = _readableDuration(timeDiff!);
  }

  String _readableDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    nextInsulinTimer?.cancel();
    autoUpdateTimer?.cancel();
    super.dispose();
  }
}
