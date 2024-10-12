import 'package:diapets_mobile/components/diapets_date_picker_input/diapets_date_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../diapets_input_decoration.dart';

class DiapetsDatePickerInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final Widget? suffixIcon;
  final String? errorText;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;

  final String? Function(String?)? validator;
  final void Function(DateTime?)? onSaved;

  const DiapetsDatePickerInput({
    super.key,
    required this.label,
    this.placeholder = '',
    this.suffixIcon,
    this.errorText,
    this.validator,
    this.onSaved,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
  });

  @override
  State<DiapetsDatePickerInput> createState() => _DiapetsDatePickerInputState();
}

class _DiapetsDatePickerInputState extends State<DiapetsDatePickerInput> {
  @override
  void initState() {
    super.initState();
    var diapetsDatePickerController = Get.put(DiapetsDatePickerController());
    if (widget.initialDate != null) {
      diapetsDatePickerController.selectedDate.value = widget.initialDate!;
    }
  }

  void openDatePicker(BuildContext context) {
    var diapetsDatePickerController = Get.find<DiapetsDatePickerController>();
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      locale: const Locale('pt', 'BR'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Theme.of(context).colorScheme.onPrimary,
              surface: Theme.of(context).colorScheme.surface,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    ).then((selectedDate) {
      // After selecting the date, display the time picker.
      if (selectedDate != null) {
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
          // Handle the selected date and time here.
          if (selectedTime != null) {
            DateTime selectedDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
            diapetsDatePickerController.selectedDate.value = selectedDateTime;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).colorScheme.primary;
    var diapetsDatePickerController = Get.find<DiapetsDatePickerController>();
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
            diapetsDatePickerController.selectedDate.value,
          ),
          validator: widget.validator,
          readOnly: true,
          onTap: () => openDatePicker(context),
          controller: diapetsDatePickerController.textEditingController,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFFFCFCFC),
          ),
          decoration: getDecoration(
            context,
            widget.errorText,
            widget.placeholder,
            Icon(
              Icons.calendar_month_outlined,
              color: primaryColor,
            ),
            false,
          ),
        ),
      ],
    );
  }
}
