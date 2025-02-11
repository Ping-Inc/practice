import 'package:flutter/material.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';

class SettingsActivationCell extends StatelessWidget {
  const SettingsActivationCell(
      {super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SystemTap(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(spacingFive),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SystemText(
              text: text,
              color: themeForegroundBlue,
            )
          ]),
        ));
  }
}
