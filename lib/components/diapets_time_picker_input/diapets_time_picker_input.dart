import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../diapets_input_decoration.dart';
import 'diapets_time_picker_controller.dart';

class DiapetsTimePickerInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final Widget? suffixIcon;
  final String? errorText;
  final TimeOfDay? initialTime;

  final String? Function(String?)? validator;
  final void Function(TimeOfDay?)? onSaved;

  const DiapetsTimePickerInput({
    super.key,
    required this.label,
    this.placeholder = '',
    this.suffixIcon,
    this.errorText,
    this.validator,
    this.onSaved,
    this.initialTime,
  });

  @override
  State<DiapetsTimePickerInput> createState() => _DiapetsTimePickerInputState();
}

class _DiapetsTimePickerInputState extends State<DiapetsTimePickerInput> {
  @override
  void initState() {
    super.initState();
    var diapetsDatePickerController = Get.put(DiapetsTimePickerController());
    if (widget.initialTime != null) {
      diapetsDatePickerController.selectedTime.value = widget.initialTime!;
    }
  }

  void openTimePicker(BuildContext context) {
    var diapetsDatePickerController = Get.find<DiapetsTimePickerController>();
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            timePickerTheme: TimePickerThemeData(
              dialHandColor: Theme.of(context).colorScheme.primary,
              dayPeriodColor: Theme.of(context).colorScheme.primary,
              dayPeriodTextColor: Theme.of(context).colorScheme.onPrimary,
            ),
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Theme.of(context).colorScheme.onPrimary,
              surface: Theme.of(context).colorScheme.surface,
              onSurface: Colors.white,
            ),
          ),
          child: Localizations.override(
            context: context,
            locale: const Locale('pt', 'BR'),
            child: child!,
          ),
        );
      },
    ).then((selectedTime) {
      // Handle the selected time here.
      if (selectedTime != null) {
        diapetsDatePickerController.selectedTime.value = selectedTime;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).colorScheme.primary;
    var diapetsTimePickerController = Get.find<DiapetsTimePickerController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 14, color: primaryColor),
        ),
        const SizedBox(height: 8),
        TextFormField(
          onSaved: (_) => widget.onSaved?.call(
            diapetsTimePickerController.selectedTime.value,
          ),
          validator: widget.validator,
          readOnly: true,
          onTap: () => openTimePicker(context),
          controller: diapetsTimePickerController.textEditingController,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFFFCFCFC),
          ),
          decoration: getDecoration(
            context,
            widget.errorText,
            widget.placeholder,
            Icon(
              Icons.access_time,
              color: primaryColor,
            ),
            false,
          ),
        ),
      ],
    );
  }
}
