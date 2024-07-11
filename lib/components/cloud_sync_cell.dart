import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/providers/backup_on_provider.dart';

class CloudSyncCell extends ConsumerWidget {
  const CloudSyncCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupOn = ref.watch(backupOnProvider);

    return backupOn
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SystemText(text: "Cloud Sync", size: TextSizeEnum.twentyNine),
              SystemDivider(),
              SizedBox(height: spacingFour),
              SystemText(
                text:
                    "Choose which providers you wish to sync your Ping Backups to:",
              ),
            ],
          )
        : SizedBox.shrink();
  }
}
