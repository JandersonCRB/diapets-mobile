import 'package:diapets_mobile/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authService = Get.find<AuthService>();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            authService.logout();
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
