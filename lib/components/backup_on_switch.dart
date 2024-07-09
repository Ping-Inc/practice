import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_switch.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/backup_on_provider.dart';

class BackupOnSwitch extends ConsumerWidget {
  const BackupOnSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final switchOn = ref.watch(backupOnProvider);

    return Column(children: [
      SystemText(text: switchOn ? "Turn off" : "Turn on"),
      SystemSwitch(
        value: switchOn,
        onChanged: (_) => ref.read(backupOnProvider.notifier).toggle(),
      )
    ]);
  }
}
