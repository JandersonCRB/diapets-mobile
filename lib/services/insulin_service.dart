import 'package:diapets_mobile/services/api.dart';
import 'package:get/get.dart';

class InsulinService {
  static Future<void> registerInsulin(int petId, int? glucoseLevel,
      int insulinUnits, int responsibleId, DateTime applicationTime,
      {String? observations}) async {
    Api api = Get.find();
    await api.dio.post('/api/v1/pets/$petId/insulin_applications', data: {
      'glucose_level': glucoseLevel,
      'insulin_units': insulinUnits,
      'application_time': applicationTime.toIso8601String(),
      'responsible_id': responsibleId,
      'observations': observations,
      if (glucoseLevel != null) 'glucose_level': glucoseLevel,
    });
  }

  static Future<void> updateInsulin(
      int petId,
      int insulinApplicationId,
      int? glucoseLevel,
      int insulinUnits,
      int responsibleId,
      DateTime applicationTime,
      {String? observations}) async {
    Api api = Get.find();
    await api.dio
        .put('/api/v1/insulin_applications/$insulinApplicationId', data: {
      'insulin_units': insulinUnits,
      'application_time': applicationTime.toIso8601String(),
      'responsible_id': responsibleId,
      'observations': observations,
      if (glucoseLevel != null) 'glucose_level': glucoseLevel,
    });
  }

  static Future<void> deleteInsulin(int insulinApplicationId) async {
    Api api = Get.find();
    await api.dio.delete('/api/v1/insulin_applications/$insulinApplicationId');
  }
}
