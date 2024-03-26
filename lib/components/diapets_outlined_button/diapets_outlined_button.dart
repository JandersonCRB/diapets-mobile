import 'package:flutter/material.dart';

class DiapetsOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? borderColor;
  final Widget child;
  final bool loading;

  const DiapetsOutlinedButton({
    super.key,
    this.onPressed,
    required this.child,
    this.borderColor,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    Color overridenBorderColor = borderColor ?? Theme.of(context).primaryColor;
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          // backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: const Color(0xFFFCFCFC),
          side: BorderSide(
            color: overridenBorderColor,
            width: 1,
          ),
        ),
        child: loading
            ? const CircularProgressIndicator(
                color: Color(0xFFFCFCFC),
              )
            : child,
      ),
    );
  }
}
