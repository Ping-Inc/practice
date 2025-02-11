import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/settings_navigation_cell.dart';
import 'package:practice/pages/settings/settings_backup_local_page.dart';
import 'package:practice/providers/local_backup_on_provider.dart';

class LocalBackupActivationCell extends ConsumerWidget {
  const LocalBackupActivationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool localOn = ref.watch(localBackupOnProvider);

    return SettingsNavigationCell(
      text: 'Local',
      state: localOn ? 'On' : 'Off',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SettingsBackupLocalPage(),
        ),
      ),
    );
  }
}
