import 'package:flutter/material.dart';

class DiapetsTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final Widget? suffixIcon;

  const DiapetsTextField({
    super.key,
    required this.label,
    this.placeholder = '',
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).colorScheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: primaryColor),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: TextFormField(
            expands: true,
            maxLines: null,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFFCFCFC),
            ),
            decoration: InputDecoration(
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
              contentPadding: const EdgeInsets.only(left: 16),
              fillColor: const Color(0xFF2E3641),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48),
                borderSide: const BorderSide(
                  color: Color(0xFF888D92),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48),
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
