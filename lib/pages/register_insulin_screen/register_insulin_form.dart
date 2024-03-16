import 'package:diapets_mobile/components/DiapetsPrimaryButton/diapets_primary_button.dart';
import 'package:diapets_mobile/components/DiapetsTextField/diapets_text_field.dart';
import 'package:diapets_mobile/components/diapets_date_picker_input/diapets_date_picker_input.dart';
import 'package:diapets_mobile/components/diapets_select/diapets_select.dart';
import 'package:diapets_mobile/helpers/form_validator.dart';
import 'package:diapets_mobile/pages/register_insulin_screen/register_insulin_controller.dart';
import 'package:diapets_mobile/services/pet_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterInsulinForm extends StatefulWidget {
  const RegisterInsulinForm({super.key});

  @override
  State<RegisterInsulinForm> createState() => _RegisterInsulinFormState();
}

class _RegisterInsulinFormState extends State<RegisterInsulinForm> {
  @override
  void initState() {
    super.initState();
    Get.put(RegisterInsulinController());
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
    var registerInsulinController = Get.find<RegisterInsulinController>();
    return Form(
      key: registerInsulinController.formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DiapetsTextField(
                    label: "Glicose",
                    placeholder: "mg/dL",
                    validator: FormValidator().required().build(),
                    onSaved: (String? value) {
                      registerInsulinController.glucose = int.parse(value!);
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DiapetsTextField(
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
              onSaved: (int? value) {
                registerInsulinController.responsible = petService
                    .selectedPet.value!.owners
                    .firstWhere((owner) => owner.id == value);
              },
              items: petService.selectedPet.value!.owners.map((owner) {
                return DropdownMenuItem(
                  value: owner.id,
                  child: Text(owner.firstName ?? 'Sem nome'),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            DiapetsDatePickerInput(
                label: "Data e hora",
                onSaved: (DateTime? value) {
                  registerInsulinController.datetime = value;
                }),
            const SizedBox(height: 32),
            DiapetsTextField(
              onSaved: (String? value) {
                registerInsulinController.observation = value;
              },
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
    );
  }
}
