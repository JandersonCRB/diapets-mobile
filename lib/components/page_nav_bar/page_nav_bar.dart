import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageNavbar extends StatelessWidget {
  final String title;
  const PageNavbar({
    super.key,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackButton(),
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
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
        child: const Icon(
          Icons.keyboard_backspace,
          size: 24,
          color: Color(0xFFFCFCFC),
        ),
      ),
    );
  }
}
