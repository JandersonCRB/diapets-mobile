import 'package:diapets_mobile/pages/home_screen/home_screen.dart';
import 'package:diapets_mobile/pages/login_screen/login_screen.dart';
import 'package:diapets_mobile/pages/register_insulin_screen/register_insulin_screen.dart';
import 'package:diapets_mobile/services/api.dart';
import 'package:diapets_mobile/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

void main() async {
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await dotenv.load(fileName: ".env.local");
  Get.put(Api()).onInit();
  await GetStorage.init();
  await Get.putAsync(() => AuthService().init());
  await Jiffy.setLocale('pt_br');
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
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
        ),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(
          name: '/register_insulin',
          page: () => const RegisterInsulinScreen(),
        ),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEB7C3C),
          primary: const Color(0xFFEB7C3C),
          background: const Color(0xFF1F2630),
          surface: const Color(0xFFFCFCFC),
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
        // Changing default font color to white
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFFCFCFC)),
          bodyMedium: TextStyle(color: Color(0xFFFCFCFC)),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
