import 'package:diapets_mobile/components/diapets_icon_button/diapets_icon_button.dart';
import 'package:diapets_mobile/components/max_width_container/max_width_container.dart';
import 'package:diapets_mobile/components/page_nav_bar/page_nav_bar.dart';
import 'package:diapets_mobile/pages/register_insulin_screen/register_insulin_controller.dart';
import 'package:diapets_mobile/pages/register_insulin_screen/register_insulin_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'delete_insulin_dialog.dart';

class RegisterInsulinScreen extends StatelessWidget {
  const RegisterInsulinScreen({super.key});

  showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const DeleteInsulinDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    RegisterInsulinController registerInsulinController = Get.find();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: MaxWidthContainer(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Column(
                children: [
                  Obx(
                    () => PageNavbar(
                      actions: registerInsulinController.isEditing.value
                          ? [
                              DiapetsIconButton(
                                onTap: () =>
                                    showDeleteConfirmationDialog(context),
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ]
                          : [],
                      title: registerInsulinController.isEditing.value
                          ? 'Registro'
                          : 'Novo registro',
                    ),
                  ),
                  const SizedBox(height: 48),
                  const RegisterInsulinForm(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
