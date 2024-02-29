import 'package:diapets_mobile/pages/login_screen/login_screen.dart';
import 'package:diapets_mobile/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await dotenv.load(fileName: ".env.local");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var api = Get.put(Api());
    api.onInit();
    return GetMaterialApp(
      title: 'Flutter Demo',
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
