import 'package:diapets_mobile/components/diapets_icon_button/diapets_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageNavbar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  const PageNavbar({
    super.key,
    this.title = '',
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const BackButton(),
            const Spacer(),
            ...?actions,
          ],
        ),
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
    return DiapetsIconButton(
      icon: const Icon(
        Icons.keyboard_backspace_rounded,
        weight: 300,
      ),
      onTap: () {
        Get.back();
      },
    );
  }
}
