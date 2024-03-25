import 'package:diapets_mobile/components/page_nav_bar/page_nav_bar.dart';
import 'package:diapets_mobile/pages/register_insulin_screen/register_insulin_controller.dart';
import 'package:diapets_mobile/pages/register_insulin_screen/register_insulin_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterInsulinScreen extends StatelessWidget {
  const RegisterInsulinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterInsulinController registerInsulinController = Get.find();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Column(
              children: [
                Obx(
                  () => PageNavbar(
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
    );
  }
}
