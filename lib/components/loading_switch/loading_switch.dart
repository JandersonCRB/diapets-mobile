import 'package:flutter/material.dart';

class LoadingSwitch extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const LoadingSwitch({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        child: Center(
          child: const CircularProgressIndicator(),
        ),
      );
    }
    return child;
  }
}
