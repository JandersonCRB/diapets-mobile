import 'package:diapets_mobile/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var displayPassword = false.obs;

  void toggleDisplayPassword() {
    displayPassword.value = !displayPassword.value;
  }

  String? email;
  String? password;

  var invalidCredentials = false.obs;

  void login() {
    Api api = Get.find<Api>();

    api.post('/api/v1/auth/login', data: {
      'email': email,
      'password': password,
    }).then((response) {
      print(response.statusCode);
      print(response.data);
    }).catchError((error) {
      if (error.response != null) {
        if (error.response.statusCode == 401 ||
            error.response.statusCode == 404) {
          invalidCredentials.value = true;
        }
      } else {
        Get.snackbar(
          "Sem conexão",
          "Você está sem conexão com a internet",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          colorText: Colors.white,
        );
      }
    });
  }
}
