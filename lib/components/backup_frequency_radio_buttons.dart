import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_radio_button.dart';
import 'package:practice/enums/backup_frequency_enum.dart';
import 'package:practice/extensions/backup_frequency_enum_extensions.dart';
import 'package:practice/extensions/string_extensions.dart';
import 'package:practice/providers/backup_frequency_provider.dart';
import 'package:practice/providers/backup_on_provider.dart';

class BackupFrequencyRadioButtons extends ConsumerWidget {
  const BackupFrequencyRadioButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final switchOn = ref.watch(backupOnProvider);
    final currentFrequency = ref.watch(backupFrequencyProvider);

    return Column(children: [
      Text("choose frequency"),
      for (BackupFrequencyEnum frequency in BackupFrequencyEnum.values)
        SystemRadioButton(
          title: frequency.title(context).capitalize(),
          value: frequency,
          groupValue: currentFrequency,
          enabled: switchOn,
          onChanged: (p0) {
            ref.read(backupFrequencyProvider.notifier).setFrequency(p0);
          },
        )
    ]);
  }
}
