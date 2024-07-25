import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/settings_scaffold.dart';
import 'package:practice/design_system/system_text.dart';

class SettingsFontSizePage extends ConsumerWidget {
  const SettingsFontSizePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsScaffold(
        title: "Font Size", child: SystemText(text: "Standard"));
  }
}
