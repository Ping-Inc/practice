import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';

class SettingsNavigationCell extends StatelessWidget {
  const SettingsNavigationCell(
      {super.key,
      required this.text,
      required this.state,
      required this.onTap});

  final String text;
  final String state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SystemTap(
        onTap: onTap,
        child: Padding(
            padding: EdgeInsets.all(spacingFive),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SystemText(text: text),
                  Row(children: [
                    SystemText(text: state),
                    SizedBox(width: spacingFive),
                    Icon(PhosphorIcons.caret_right,
                        color: Theme.of(context).colorScheme.primary),
                  ])
                ])));
  }
}
