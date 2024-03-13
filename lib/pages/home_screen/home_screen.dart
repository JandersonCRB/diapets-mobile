import 'package:diapets_mobile/components/DiapetsPrimaryButton/diapets_primary_button.dart';
import 'package:diapets_mobile/pages/home_screen/home_nav_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const HomeNavBar(),
            const Spacer(),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 220,
                maxHeight: 40,
              ),
              child: DiapetsPrimaryButton(
                child: const Row(
                  children: [
                    Text("Novo registro de insulina"),
                  ],
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
