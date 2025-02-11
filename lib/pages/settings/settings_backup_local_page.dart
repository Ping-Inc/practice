import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_switch.dart';
import 'package:practice/pages/settings/settings_scaffold.dart';
import 'package:practice/providers/local_backup_on_provider.dart';

class SettingsBackupLocalPage extends ConsumerWidget {
  const SettingsBackupLocalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool localOn = ref.watch(localBackupOnProvider);

    return SettingsScaffold(
        title: "Local Backup",
        subtitle: localOn
            ? 'Pings you capture are automatically backed up to a CSV file stored in the Files app on this device. Pings are not stored anywhere else.'
            : 'The Pings you have captured are not backed up to a folder on your phone, but may not be backed up to the cloud. It is up to you to store copies of this backup file.',
        child: SystemSwitch(
            value: localOn,
            onChanged: (val) =>
                ref.read(localBackupOnProvider.notifier).toggle()));
  }
}
