import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InjectionIcon extends StatelessWidget {
  const InjectionIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/icons/injection.svg");
  }
}
