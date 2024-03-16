import 'package:flutter/material.dart';

import '../diapets_input_decoration.dart';

class DiapetsSelect<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final String label;
  final String placeholder;
  final Widget? suffixIcon;
  final void Function(T?)? onSaved;

  const DiapetsSelect({
    super.key,
    required this.items,
    required this.label,
    this.placeholder = '',
    this.suffixIcon,
    this.onSaved,
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
        DropdownButtonFormField<T>(
          items: items,
          onSaved: onSaved,
          onChanged: (T? value) {},
          value: items.first.value,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFFFCFCFC),
          ),
          decoration: getDecoration(
            context,
            null,
            placeholder,
            suffixIcon,
            false,
          ),
        ),
      ],
    );
  }
}
