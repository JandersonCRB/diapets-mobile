import 'package:flutter/material.dart';

class MaxWidthContainer extends StatelessWidget {
  final Widget child;
  const MaxWidthContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 900,
          ),
          child: child,
        ),
      ),
    );
  }
}
