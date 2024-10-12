import 'package:diapets_mobile/components/DiapetsPrimaryButton/diapets_primary_button.dart';
import 'package:diapets_mobile/components/DiapetsTextField/diapets_text_field.dart';
import 'package:diapets_mobile/components/diapets_date_picker_input/diapets_date_picker_input.dart';
import 'package:diapets_mobile/components/diapets_select/diapets_select.dart';
import 'package:diapets_mobile/components/loading_switch/loading_switch_builder.dart';
import 'package:diapets_mobile/helpers/form_validator.dart';
import 'package:diapets_mobile/models/user.dart';
import 'package:diapets_mobile/pages/register_insulin_screen/register_insulin_controller.dart';
import 'package:diapets_mobile/services/auth_service.dart';
import 'package:diapets_mobile/services/pet_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../components/diapets_time_picker_input/diapets_time_picker_input.dart';

class RegisterInsulinForm extends StatefulWidget {
  const RegisterInsulinForm({super.key});

  @override
  State<RegisterInsulinForm> createState() => _RegisterInsulinFormState();
}

class _RegisterInsulinFormState extends State<RegisterInsulinForm> {
  @override
  void initState() {
    super.initState();
  }

  void submit() {
    var registerInsulinController = Get.find<RegisterInsulinController>();
    var petService = Get.find<PetService>();

    if (registerInsulinController.formKey.currentState!.validate()) {
      registerInsulinController.formKey.currentState!.save();
      registerInsulinController.submit(petService.selectedPet.value!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    PetService petService = Get.find();
    AuthService authService = Get.find();
    var registerInsulinController = Get.find<RegisterInsulinController>();
    List<User> sortedOwners = petService.selectedPet.value!.owners;

    sortedOwners.sort((a, b) {
      // Check if a is the current user
      if (a.id == authService.currentUser!.id) {
        return -1; // Move a before b
      }
      // Check if b is the current user
      else if (b.id == authService.currentUser!.id) {
        return 1; // Move b before a
      }
      // If neither a nor b is the current user, maintain the original order
      else {
        return a.firstName!.compareTo(b.firstName!);
      }
    });

    return Form(
      key: registerInsulinController.formKey,
      child: Obx(
        () => LoadingSwitchBuilder(
          isLoading: registerInsulinController.initialLoading.value,
          builder: () => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DiapetsTextField(
                        initialValue: registerInsulinController
                                .insulinApplication.value?.glucoseLevel
                                ?.toString() ??
                            '',
                        label: "Glicose",
                        placeholder: "mg/dL",
                        // validator: FormValidator().required().build(),
                        onSaved: (String? value) {
                          if (value != null && value.isNotEmpty == true) {
                            registerInsulinController.glucose =
                                int.parse(value);
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DiapetsTextField(
                        initialValue: registerInsulinController
                            .insulinApplication.value?.insulinUnits
                            .toString(),
                        label: "Unid. de insulina",
                        placeholder: "unidades",
                        validator: FormValidator().required().build(),
                        onSaved: (String? value) {
                          registerInsulinController.insulinUnits =
                              int.parse(value!);
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                DiapetsSelect<int>(
                  label: "Responsável",
                  initialValue: registerInsulinController
                              .insulinApplication.value?.user?.id !=
                          null
                      ? (int value) {
                          return value ==
                              registerInsulinController
                                  .insulinApplication.value?.user?.id;
                        }
                      : null,
                  onSaved: (int? value) {
                    registerInsulinController.responsible = petService
                        .selectedPet.value!.owners
                        .firstWhere((owner) => owner.id == value);
                  },
                  items: sortedOwners.map((owner) {
                    return DropdownMenuItem(
                      value: owner.id,
                      child: Text(owner.firstName ?? 'Sem nome'),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: DiapetsDatePickerInput(
                        label: "Data",
                        firstDate: DateTime(200),
                        lastDate: DateTime.now(),
                        initialDate: registerInsulinController
                            .insulinApplication.value?.applicationTime,
                        onSaved: (DateTime? value) {
                          registerInsulinController.date = value;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DiapetsTimePickerInput(
                        label: "Hora",
                        initialTime: registerInsulinController
                                    .insulinApplication
                                    .value
                                    ?.applicationTime !=
                                null
                            ? TimeOfDay(
                                hour: registerInsulinController
                                    .insulinApplication
                                    .value!
                                    .applicationTime!
                                    .hour,
                                minute: registerInsulinController
                                    .insulinApplication
                                    .value!
                                    .applicationTime!
                                    .minute,
                              )
                            : null,
                        onSaved: (TimeOfDay? value) {
                          registerInsulinController.time = value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                DiapetsTextField(
                  onSaved: (String? value) {
                    registerInsulinController.observation = value;
                  },
                  initialValue: registerInsulinController
                      .insulinApplication.value?.observations,
                  label: "Observações (opcional)",
                  multiline: true,
                ),
                const SizedBox(height: 64),
                Obx(
                  () => DiapetsPrimaryButton(
                    onPressed: submit,
                    loading: registerInsulinController.loading.value,
                    child: const Text("Salvar registro"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
