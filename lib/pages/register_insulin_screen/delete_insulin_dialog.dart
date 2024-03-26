import 'package:diapets_mobile/components/DiapetsPrimaryButton/diapets_primary_button.dart';
import 'package:diapets_mobile/components/diapets_outlined_button/diapets_outlined_button.dart';
import 'package:diapets_mobile/pages/register_insulin_screen/register_insulin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteInsulinDialog extends StatelessWidget {
  const DeleteInsulinDialog({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterInsulinController registerInsulinController = Get.find();
    return AlertDialog(
      title: Text(
        'Apagar registro',
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      content: const Text('Deseja realmente apagar esse registro de insulina?'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DiapetsOutlinedButton(
                onPressed: () {
                  Get.back();
                },
                borderColor: Theme.of(context).colorScheme.error,
                child: Text(
                  'Não, voltar',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Obx(
                () => DiapetsPrimaryButton(
                  loading: registerInsulinController.deleteLoading.value,
                  onPressed: () async {
                    await registerInsulinController.deleteInsulin();
                    Get.back();
                    Get.back();
                  },
                  borderColor: Theme.of(context).colorScheme.error,
                  child: const Text('Apagar'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
