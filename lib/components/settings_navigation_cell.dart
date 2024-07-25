import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';

class SettingsNavigationCell extends StatelessWidget {
  const SettingsNavigationCell(
      {super.key, required this.text, required this.state});

  final String text;
  final String state;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(spacingFive),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SystemText(text: text),
          Row(children: [
            SystemText(
                text: state, color: Theme.of(context).colorScheme.secondary),
            SizedBox(width: spacingFive),
            Icon(PhosphorIcons.caret_right,
                color: Theme.of(context).colorScheme.secondary),
          ])
        ]));
  }
}
