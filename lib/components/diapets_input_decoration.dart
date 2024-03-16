import 'package:flutter/material.dart';

InputDecoration getDecoration(
  BuildContext context,
  String? errorText,
  String? placeholder,
  Widget? suffixIcon,
  bool multiline,
) {
  double borderRadius = multiline ? 16 : 48;
  var primaryColor = Theme.of(context).colorScheme.primary;
  return InputDecoration(
    errorText: errorText,
    suffixIcon: suffixIcon == null
        ? null
        : Padding(
            padding: const EdgeInsets.only(right: 16),
            child: suffixIcon,
          ),
    suffixIconColor: primaryColor,
    hintText: placeholder,
    hintStyle: const TextStyle(
      fontSize: 14,
      color: Color(0xFF494F59),
    ),
    contentPadding: const EdgeInsets.only(left: 16, bottom: 16, right: 8),
    fillColor: const Color(0xFF2E3641),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(
        color: Color(0xFF888D92),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: primaryColor,
      ),
    ),
  );
}
