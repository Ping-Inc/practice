import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/backup_on_switch.dart';
import 'package:practice/components/cloud_sync_cell.dart';
import 'package:practice/components/local_backup_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/design_system/system_text.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        left: spacingTwo, right: spacingTwo, top: spacingFour),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              HapticFeedback.selectionClick();
                              Navigator.pop(context);
                            },
                            child: SystemText(text: "Back")),
                      ],
                    )),
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: spacingFour,
                          right: spacingFour,
                          top: spacingFour),
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
                      )),
                ))
              ],
            )));
  }
}
