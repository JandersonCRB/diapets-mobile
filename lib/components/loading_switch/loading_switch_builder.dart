import 'package:flutter/material.dart';

class LoadingSwitchBuilder extends StatelessWidget {
  final bool isLoading;

  final Widget Function() builder;
  const LoadingSwitchBuilder({
    super.key,
    required this.isLoading,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return builder();
  }
}
