import 'package:diapets_mobile/components/DiapetsPrimaryButton/diapets_primary_button.dart';
import 'package:diapets_mobile/components/DiapetsTextField/diapets_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 56,
            ),
            SvgPicture.asset(
              'assets/images/pana.svg',
              semanticsLabel: 'Mulher fazendo login',
            ),
            const SizedBox(
              height: 48,
            ),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void forgotPassword(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: const Text("Esqueci minha senha"),
            content: const Text(
              "Não se preocupe, vamos te ajudar a recuperar sua senha... Um dia, quando o dev resolver implementar essa feature",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Voltar"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    var loginController = Get.find<LoginController>();

    return Form(
      key: formKey,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login",
              style: TextStyle(
                color: primaryColor,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            const DiapetsTextField(
              label: "Email",
              placeholder: "exemplo@email.com",
            ),
            const SizedBox(height: 32),
            Obx(
              () => DiapetsTextField(
                label: "Senha",
                placeholder: "Digite sua senha",
                obscureText: !loginController.displayPassword.value,
                suffixIcon: IconButton(
                  onPressed: () {
                    loginController.toggleDisplayPassword();
                  },
                  icon: loginController.displayPassword.value
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => forgotPassword(context),
                child: Text(
                  "Esqueci minha senha?",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            DiapetsPrimaryButton(
              onPressed: () {},
              child: const Text("Entrar"),
            )
          ],
        ),
      ),
    );
  }
}
