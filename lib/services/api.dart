import 'package:diapets_mobile/services/auth_service.dart';
import 'package:diapets_mobile/services/logger.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class Api extends DioForNative {
  void onInit() {
    options.baseUrl = dotenv.env['API_URL']!;

    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          AuthService authService = Get.find();
          if (authService.isSignedIn) {
            options.headers['Authorization'] = 'Bearer ${authService.token}';
          }
          return handler.next(options); //continue
        },
        onError: (DioException e, handler) {
          logger.e("Error: ${e.response?.data}");
          if (e.response?.statusCode == 401 &&
              e.response?.data['error_code'] == 'INVALID_TOKEN') {
            AuthService authService = Get.find();
            authService.logout(redirect: false);
          }
          return handler.next(e); //continue
        },
      ),
    );
  }
}
