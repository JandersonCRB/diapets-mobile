import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUiCustomization extends StatelessWidget {
  final Color? bottomNavigationColor;
  final Widget child;

  const SystemUiCustomization({
    super.key,
    required this.child,
    this.bottomNavigationColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor:
            bottomNavigationColor ?? Theme.of(context).canvasColor,
      ),
      child: child,
    );
  }
}
