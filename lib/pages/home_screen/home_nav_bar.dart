import 'package:flutter/material.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return Row(
      children: [
        Image.asset(
          "assets/images/logo_purple.png",
          width: 106,
          height: 32,
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            print("Home");
          },
          borderRadius: BorderRadius.circular(99),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2E3641),
              borderRadius: BorderRadius.circular(99),
            ),
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Icon(
              Icons.history,
              size: 24,
              color: primaryColor,
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        InkWell(
          onTap: () {
            print("Home");
          },
          borderRadius: BorderRadius.circular(99),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2E3641),
              borderRadius: BorderRadius.circular(99),
            ),
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Icon(
              Icons.logout,
              size: 24,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
