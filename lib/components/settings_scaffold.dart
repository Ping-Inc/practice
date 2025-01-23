import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';

class SettingsScaffold extends StatelessWidget {
  const SettingsScaffold({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Padding(
                padding: EdgeInsets.all(spacingFour),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SystemButton(
                      onTap: () => context.pop(),
                      text: 'Settings',
                      icon: PhosphorIcons.caret_left,
                    ),
                    SystemText(
                      text: title,
                      size: TextSizeEnum.thirtySix,
                    ),
                    child
                  ],
                ))));
  }
}
