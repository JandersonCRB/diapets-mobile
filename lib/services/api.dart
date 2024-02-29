import 'package:dio/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api extends DioForNative {
  void onInit() {
    options.baseUrl = dotenv.env['API_URL']!;
    // It's will attach 'apikey' property on header from all requests
    // httpClient.addRequestModifier((request) {
    //   request.headers['apikey'] = '12345678';
    //   return request;
    // });
  }
}
