import 'package:diapets_mobile/models/pet.dart';
import 'package:diapets_mobile/services/logger.dart';
import 'package:get/get.dart';

import 'api.dart';

class PetService extends GetxService {
  Rxn<Pet> selectedPet = Rxn<Pet>();

  Future<void> init() async {
    await setInitialPet();
  }

  Future<void> setInitialPet() async {
    List<Pet> pets = await listPets();
    if (pets.isNotEmpty) {
      selectedPet.value = pets.first;
    }
  }

  Future<List<Pet>> listPets() async {
    try {
      Api api = Get.find();
      var response = await api.get('/api/v1/pets');
      List<Pet> pets =
          response.data.map<Pet>((pet) => Pet.fromJson(pet)).toList();
      return pets;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
