import 'package:diapets_mobile/services/api.dart';
import 'package:get/get.dart';

class InsulinService {
  // requires :glucose_level, type: Integer
  // requires :insulin_units, type: Integer
  // requires :application_time, type: DateTime
  // optional :observations, type: String
  static Future<void> registerInsulin(int petId, int glucoseLevel, int insulinUnits,
      int responsibleId, DateTime applicationTime,
      {String? observations}) async {
    Api api = Get.find();
    api.post('/api/v1/pets/$petId/insulin_applications', data: {
      'glucose_level': glucoseLevel,
      'insulin_units': insulinUnits,
      'application_time': applicationTime.toIso8601String(),
      'responsible_id': responsibleId,
      'observations': observations,
    });
  }
}
