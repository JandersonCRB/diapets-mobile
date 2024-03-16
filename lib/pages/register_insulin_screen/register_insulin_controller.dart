import 'package:diapets_mobile/models/user.dart';
import 'package:diapets_mobile/services/insulin_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterInsulinController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var loading = false.obs;

  int? glucose;
  int? insulinUnits;
  DateTime? datetime;
  String? observation;
  User? responsible;

  Future<void> submit(int petId) async {
    loading.value = true;

    try {
      await InsulinService.registerInsulin(
        petId,
        glucose!,
        insulinUnits!,
        responsible!.id!,
        datetime!,
        observations: observation,
      );
      Get.back();
    } catch (e) {
      print(e);
      Get.snackbar(
        "Erro",
        "Ocorreu um erro inesperado. Tente novamente mais tarde.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      loading.value = false;
    }

    await Future.delayed(const Duration(seconds: 2));
    loading.value = false;
  }
}
