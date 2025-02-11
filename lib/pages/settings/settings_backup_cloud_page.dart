import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_switch.dart';
import 'package:practice/pages/settings/settings_scaffold.dart';
import 'package:practice/providers/cloud_backup_on_provider.dart';

class SettingsBackupCloudPage extends ConsumerWidget {
  const SettingsBackupCloudPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool cloudOn = ref.watch(cloudBackupOnProvider);

    return SettingsScaffold(
        title: "Cloud Backup",
        subtitle: cloudOn
            ? "The Pings you have captured are being stored in your iCloud account. You can delete and reinstall the app and these Pings will reappear."
            : "The Pings you have captured are not being stored in iCloud. When you delete the app, these Pings will disappear.",
        child: SystemSwitch(
            value: cloudOn,
            onChanged: (val) =>
                ref.read(cloudBackupOnProvider.notifier).toggle()));
  }
}
