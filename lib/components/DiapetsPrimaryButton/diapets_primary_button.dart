import 'package:flutter/material.dart';

class DiapetsPrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  const DiapetsPrimaryButton({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: const Color(0xFFFCFCFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: child,
      ),
    );
  }
}
