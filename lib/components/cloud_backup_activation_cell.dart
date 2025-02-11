import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/settings_navigation_cell.dart';
import 'package:practice/pages/settings/settings_backup_cloud_page.dart';
import 'package:practice/providers/cloud_backup_on_provider.dart';

class CloudBackupActivationCell extends ConsumerWidget {
  const CloudBackupActivationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool cloudOn = ref.watch(cloudBackupOnProvider);

    return SettingsNavigationCell(
      text: 'Cloud',
      state: cloudOn ? 'On' : 'Off',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SettingsBackupCloudPage(),
        ),
      ),
    );
  }
}
