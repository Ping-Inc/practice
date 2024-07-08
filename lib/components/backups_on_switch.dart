import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/neighborhood_cell.dart';
import 'package:practice/components/ping_id_cell.dart';
import 'package:practice/components/resizing_text_cell.dart';
import 'package:practice/components/time_row.dart';
import 'package:practice/components/weather_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_switch.dart';
import 'package:practice/providers/backup_on_provider.dart';
import 'package:practice/providers/current_ping_provider.dart';

class BackupsOnSwitch extends ConsumerWidget {
  const BackupsOnSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final switchOn = ref.watch(backupOnProvider);

    return Column(children: [
      Text(switchOn ? "Turn off" : "Turn on"),
      SystemSwitch(
        value: switchOn,
        onChanged: (_) => ref.read(backupOnProvider.notifier).toggle(),
      )
    ]);
  }
}
