import 'package:diapets_mobile/components/diapets_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DiapetsTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? errorText;
  final bool multiline;
  final String? initialValue;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const DiapetsTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.placeholder = '',
    this.suffixIcon,
    this.errorText,
    this.validator,
    this.onSaved,
    this.multiline = false,
    this.initialValue,
    this.inputFormatters = const [],
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
        TextFormField(
          initialValue: initialValue,
          maxLines: multiline ? 5 : 1,
          onSaved: onSaved,
          validator: validator,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFFFCFCFC),
          ),
          decoration: getDecoration(
            context,
            errorText,
            placeholder,
            suffixIcon,
            multiline,
          ),
        ),
      ],
    );
  }
}
