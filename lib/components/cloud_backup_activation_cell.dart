import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/settings_navigation_cell.dart';
import 'package:practice/pages/settings/settings_backup_cloud_page.dart';

class CloudBackupActivationCell extends ConsumerWidget {
  const CloudBackupActivationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsNavigationCell(
      text: 'Cloud',
      state: 'Verify',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SettingsBackupCloudPage(),
        ),
      ),
    );
  }
}
