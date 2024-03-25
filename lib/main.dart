import 'package:diapets_mobile/pages/home_screen/home_screen.dart';
import 'package:diapets_mobile/pages/insulin_log_screen/insulin_log_controller.dart';
import 'package:diapets_mobile/pages/insulin_log_screen/insulin_log_screen.dart';
import 'package:diapets_mobile/pages/login_screen/login_screen.dart';
import 'package:diapets_mobile/pages/register_insulin_screen/register_insulin_controller.dart';
import 'package:diapets_mobile/pages/register_insulin_screen/register_insulin_screen.dart';
import 'package:diapets_mobile/services/api.dart';
import 'package:diapets_mobile/services/auth_service.dart';
import 'package:diapets_mobile/services/push_notifications_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

import 'firebase_options.dart';

void main() async {
  await initServices();
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> initServices() async {
  await dotenv.load(fileName: ".env.local");
  Get.put(Api()).onInit();
  await GetStorage.init();
  var authService = Get.put(AuthService());
  await authService.init();
  await Jiffy.setLocale('pt_br');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  var pushNotificationsService = Get.put(PushNotificationsService());
  await pushNotificationsService.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var authService = Get.find<AuthService>();
    return GetMaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      initialRoute: authService.isSignedIn ? '/home' : '/login',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          children: [
            GetPage(
              name: '/insulin_log',
              binding: BindingsBuilder(() {
                Get.put(InsulinLogController());
              }),
              page: () => const InsulinLogScreen(),
            ),
          ],
        ),
        GetPage(
          name: '/register_insulin',
          binding: BindingsBuilder(() {
            Get.put(RegisterInsulinController());
          }),
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
    );
  }
}
