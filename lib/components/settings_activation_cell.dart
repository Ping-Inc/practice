import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/extensions/color_extensions.dart';
import 'package:practice/providers/base_color_provider.dart';

class SettingsActivationCell extends ConsumerWidget {
  const SettingsActivationCell(
      {super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SystemTap(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(spacingFive),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SystemText(
              text: text,
              color: Theme.of(context).colorScheme.outline,
            )
          ]),
        ));
  }
}
