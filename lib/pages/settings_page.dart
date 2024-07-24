import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/backup_on_switch.dart';
import 'package:practice/components/cloud_sync_cell.dart';
import 'package:practice/components/local_backup_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_divider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackupOnSwitch(),
            SystemDivider(),
            SizedBox(height: spacingFour),
            LocalBackupCell(),
            SizedBox(height: spacingSix),
            CloudSyncCell(),
          ],
        ));
  }
}
