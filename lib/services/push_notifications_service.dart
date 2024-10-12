import 'package:diapets_mobile/services/api.dart';
import 'package:diapets_mobile/services/auth_service.dart';
import 'package:diapets_mobile/services/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class PushNotificationsService extends GetxController {
  String? fcmToken;
  init() async {
    askPermission();
    getAndUpdateToken();
  }

  askPermission() {
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      criticalAlert: true,
      carPlay: true,
    );
  }

  getAndUpdateToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      updateToken(fcmToken!);
    }
  }

  updateToken(String token) async {
    var api = Get.find<Api>();
    var authService = Get.find<AuthService>();
    if (authService.isSignedIn) {
      try {
        await api.post('/api/v1/users/push_token', data: {'token': token});
      } catch (e) {
        logger.e(e);
      }
    }
  }
}
