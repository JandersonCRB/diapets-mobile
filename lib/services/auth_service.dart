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

  void logout() {
    token = null;
    Get.offAllNamed('/login');
  }

  Future<AuthService> init() async {
    _token = GetStorage().read('token');
    Api api = Get.find();

    var response = await api.get('/api/v1/auth/user');
    currentUser = User.fromJson(response.data);
    return this;
  }
}
