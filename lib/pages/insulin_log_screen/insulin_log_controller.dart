import 'package:diapets_mobile/models/insulin_application.dart';
import 'package:diapets_mobile/models/insulin_application_filters.dart';
import 'package:diapets_mobile/services/api.dart';
import 'package:diapets_mobile/services/pet_service.dart';
import 'package:get/get.dart';

class InsulinLogController extends GetxController {
  var loading = true.obs;
  var loadingFilters = true.obs;

  Rxn<InsulinApplicationFilters> insulinApplicationFilters =
      Rxn<InsulinApplicationFilters>();

  // key = "yyyy-MM'
  // value is a list of days in the month 'MM-dd'
  var monthMap = <String, List<String>>{}.obs;

  var dayMap = <String, List<InsulinApplication>>{}.obs;

  var monthList = <String>[].obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      await getInsulinFilters();
      await getInsulinLog();
    } finally {
      loading.value = false;
    }
  }

  getInsulinFilters() async {
    Api api = Get.find<Api>();
    PetService petService = Get.find<PetService>();
    loadingFilters.value = true;
    try {
      var response = await api.get(
          "/api/v1/pets/${petService.selectedPet.value!.id}/insulin_applications/filters");
      insulinApplicationFilters.value =
          InsulinApplicationFilters.fromJson(response.data);
      print(insulinApplicationFilters.toJson());
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao carregar filtros');
      print(e);
    } finally {
      loadingFilters.value = false;
    }
  }

  getInsulinLog() async {
    Api api = Get.find<Api>();
    PetService petService = Get.find<PetService>();
    var response = await api.get(
        '/api/v1/pets/${petService.selectedPet.value!.id}/insulin_applications');

    monthList.clear();
    monthMap.clear();
    dayMap.clear();

    List<InsulinApplication> insulinApplications =
        response.data.map<InsulinApplication>((e) {
      return InsulinApplication.fromJson(e);
    }).toList();

    for (var insulinApplication in insulinApplications) {
      var applicationTime = insulinApplication.applicationTime!;
      String monthMapKey = "${applicationTime.year}-${applicationTime.month}";
      String dayMapKey = "${applicationTime.month}-${applicationTime.day}";
      createOrAddMaps(monthMapKey, dayMapKey, insulinApplication);
    }
  }

  createOrAddMaps(String monthMapKey, String dayMapKey,
      InsulinApplication insulinApplication) {
    if (!monthMap.containsKey(monthMapKey)) {
      monthMap[monthMapKey] = [];
    }

    if (!monthList.contains(monthMapKey)) {
      monthList.add(monthMapKey);
    }

    if (!monthMap[monthMapKey]!.contains(dayMapKey)) {
      monthMap[monthMapKey]!.add(dayMapKey);
    }

    if (!dayMap.containsKey(dayMapKey)) {
      dayMap[dayMapKey] = [];
    }
    dayMap[dayMapKey]!.add(insulinApplication);
  }
}
