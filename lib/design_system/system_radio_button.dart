import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice/design_system/system_text.dart';

class SystemRadioButton extends StatelessWidget {
  const SystemRadioButton(
      {super.key,
      required this.title,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.enabled});

  final String title;
  final dynamic value;
  final dynamic groupValue;
  final Function(dynamic) onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<dynamic>(
      dense: true,
      title: SystemText(
        text: title,
      ),
      value: value,
      groupValue: groupValue,
      onChanged: enabled
          ? (value) {
              HapticFeedback.selectionClick();
              onChanged(value);
            }
          : null,
    );
  }
}
