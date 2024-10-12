import 'package:diapets_mobile/models/user.dart';
import 'package:diapets_mobile/services/api.dart';
import 'package:diapets_mobile/services/logger.dart';
import 'package:diapets_mobile/services/push_notifications_service.dart';
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

  login(String token, User user) {
    this.token = token;
    currentUser = user;
    updatePushTokens();
  }

  updatePushTokens() {
    var pushNotificationsService = Get.find<PushNotificationsService>();
    pushNotificationsService.getAndUpdateToken();
  }

  void logout({bool redirect = true}) {
    token = null;
    if (redirect) {
      Get.offAllNamed('/login');
    }
  }

  Future<AuthService> init() async {
    _token = GetStorage().read('token');
    if (_token != null) {
      await afterSignIn();
    }

    return this;
  }

  afterSignIn() async {
    await getCurrentUser();
  }

  getCurrentUser() async {
    Api api = Get.find();
    try {
      var response = await api.get('/api/v1/auth/user');
      currentUser = User.fromJson(response.data);
    } catch (e) {
      logger.e(e);
    }
  }
}
