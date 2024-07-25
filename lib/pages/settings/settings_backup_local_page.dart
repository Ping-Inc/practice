import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/settings_scaffold.dart';
import 'package:practice/design_system/system_text.dart';

class SettingsBackupLocalPage extends ConsumerWidget {
  const SettingsBackupLocalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsScaffold(title: "Local", child: SystemText(text: "Local"));
  }
}
