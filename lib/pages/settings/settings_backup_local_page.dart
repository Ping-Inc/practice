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
            ? 'Pings you capture are automatically backed up to a CSV file stored in the Files app on this device. To save a copy to your iCloud account, visit the "Cloud" section within Settings.'
            : 'The Pings you capture from this point forward will not be backed up locally or to the cloud. These Ping will be lost if/when you choose to uninstall the Ping Practice app.',
        child: SystemSwitch(
            value: localOn,
            onChanged: (val) =>
                ref.read(localBackupOnProvider.notifier).toggle()));
  }
}
