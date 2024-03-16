import 'package:diapets_mobile/components/diapets_date_picker_input/diapets_date_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../diapets_input_decoration.dart';

class DiapetsDatePickerInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final Widget? suffixIcon;
  final String? errorText;
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
  });

  @override
  State<DiapetsDatePickerInput> createState() => _DiapetsDatePickerInputState();
}

class _DiapetsDatePickerInputState extends State<DiapetsDatePickerInput> {
  @override
  void initState() {
    super.initState();
    Get.put(DiapetsDatePickerController());
  }

  void openDatePicker(BuildContext context) {
    var diapetsDatePickerController = Get.find<DiapetsDatePickerController>();
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((selectedDate) {
      // After selecting the date, display the time picker.
      if (selectedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
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
