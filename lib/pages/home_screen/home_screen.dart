import 'package:diapets_mobile/components/DiapetsPrimaryButton/diapets_primary_button.dart';
import 'package:diapets_mobile/components/icons/injection_icon.dart';
import 'package:diapets_mobile/components/max_width_container/max_width_container.dart';
import 'package:diapets_mobile/components/system_ui_customization.dart';
import 'package:diapets_mobile/pages/home_screen/home_nav_bar.dart';
import 'package:diapets_mobile/services/pet_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_content.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initControllers() async {
    PetService petService = Get.find();
    HomeController homeController = Get.find();
    await petService.init();
    int petId = petService.selectedPet.value!.id!;

    await homeController.init(petId);
  }

  @override
  void initState() {
    super.initState();
    Get.put(PetService());
    Get.put(HomeController());
    initControllers();
  }

  void gotoRegisterInsulin() {
    PetService petService = Get.find();
    HomeController homeController = Get.find();
    Get.toNamed('/register_insulin')?.then((_) {
      homeController.updateData(petService.selectedPet.value!.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaxWidthContainer(
        child: SystemUiCustomization(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HomeNavBar(),
                  const SizedBox(height: 32),
                  const HomeContent(),
                  const Spacer(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 250,
                      maxHeight: 40,
                    ),
                    child: DiapetsPrimaryButton(
                      onPressed: gotoRegisterInsulin,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InjectionIcon(),
                          SizedBox(width: 8),
                          Text(
                            "Novo registro de insulina",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
