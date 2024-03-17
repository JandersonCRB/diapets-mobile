import 'package:diapets_mobile/models/user.dart';
import 'package:diapets_mobile/services/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxController {
  String? _token;

  String? get token => _token;
  User? currentUser;

  set token(String? token) {
    if (token == null) {
      GetStorage().remove('token');
    } else {
      GetStorage().write('token', token);
    }
    _token = token;
  }

  get isSignedIn => _token != null;

  void logout({bool redirect = true}) {
    token = null;
    if (redirect) {
      Get.offAllNamed('/login');
    }
  }

  Future<AuthService> init() async {
    _token = GetStorage().read('token');
    if (_token != null) {
      await getCurrentUser();
    }

    return this;
  }

  Future<void> getCurrentUser() async {
    Api api = Get.find();
    try {
      var response = await api.get('/api/v1/auth/user');
      currentUser = User.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }
}
