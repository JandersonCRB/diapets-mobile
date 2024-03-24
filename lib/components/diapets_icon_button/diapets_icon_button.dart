import 'package:flutter/material.dart';

class DiapetsIconButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget icon;

  const DiapetsIconButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).primaryColor, size: 24),
          child: icon,
        ),
      ),
    );
  }
}
