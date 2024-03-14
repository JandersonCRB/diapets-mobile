import 'package:diapets_mobile/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class Api extends DioForNative {
  void onInit() {
    options.baseUrl = dotenv.env['API_URL']!;
    // It's will attach 'apikey' property on header from all requests
    // httpClient.addRequestModifier((request) {
    //   request.headers['apikey'] = '12345678';
    //   return request;
    // });

    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          AuthService authService = Get.find();
          if (authService.isSignedIn) {
            options.headers['Authorization'] = 'Bearer ${authService.token}';
          }
          return handler.next(options); //continue
        },
      ),
    );
  }
}
