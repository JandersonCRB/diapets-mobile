import 'package:diapets_mobile/pages/home_screen/home_screen.dart';
import 'package:diapets_mobile/pages/login_screen/login_screen.dart';
import 'package:diapets_mobile/services/api.dart';
import 'package:diapets_mobile/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await dotenv.load(fileName: ".env.local");
  Get.put(Api()).onInit();
  await GetStorage.init();
  await Get.putAsync(() => AuthService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var authService = Get.find<AuthService>();
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: authService.isSignedIn ? '/home' : '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
        ),
        GetPage(name: '/home', page: () => const HomeScreen())
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEB7C3C),
          primary: const Color(0xFFEB7C3C),
          background: const Color(0xFF1F2630),
          surface: const Color(0xFFFCFCFC),
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
