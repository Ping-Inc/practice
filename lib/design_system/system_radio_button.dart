import 'package:flutter/cupertino.dart';
// ignore: unnecessary_import
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/services.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
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
    return SystemTap(
        onTap: () => enabled ? onChanged(value) : null,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Radio(
              fillColor: WidgetStatePropertyAll(Colors.white),
              value: value,
              groupValue: groupValue,
              onChanged: null),
          SizedBox(width: spacingTwo),
          SystemText(text: title)
        ]));
  }
}
