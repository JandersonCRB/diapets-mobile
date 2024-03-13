import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxController {
  String? _token;

  String? get token => _token;

  set token(String? token) {
    if (token == null) {
      GetStorage().remove('token');
    } else {
      GetStorage().write('token', token);
    }
    _token = token;
  }

  get isSignedIn => _token != null;

  void logout() {
    token = null;
    Get.offAllNamed('/login');
  }

  Future<AuthService> init() async {
    _token = GetStorage().read('token');
    return this;
  }
}
