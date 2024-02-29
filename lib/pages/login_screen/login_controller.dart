import 'package:get/get.dart';

class LoginController extends GetxController {
  var displayPassword = false.obs;

  void toggleDisplayPassword() {
    displayPassword.value = !displayPassword.value;
  }

  String? email;
  String? password;
}
