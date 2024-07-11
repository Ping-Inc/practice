import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/backup_on_provider.dart';
import 'package:practice/utils/backup_utils.dart';

class LocalBackupCell extends ConsumerWidget {
  const LocalBackupCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupOn = ref.watch(backupOnProvider);

    return Column(
      children: [
        SystemText(
          text: backupOn
              ? "Your Pings are automatically backed up every day to a local folder which you can access. We offer different strategies for ensuring that this data is synced to a cloud."
              : "Your Pings are not being backup up.",
        ),
        if (backupOn)
          Column(children: [
            SizedBox(height: spacingFour),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: () {
                  BackupUtils.openPingsFolder();
                },
                child: Text('Open Folder'),
              )
            ])
          ]),
      ],
    );
  }
}
