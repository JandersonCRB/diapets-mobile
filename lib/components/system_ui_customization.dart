import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUiCustomization extends StatelessWidget {
  final Widget child;

  const SystemUiCustomization({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).canvasColor,
      ),
      child: child,
    );
  }
}
