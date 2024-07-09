import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/providers/ping_entry_color_provider.dart';
import 'package:practice/providers/time_provider.dart';

class TimeRow extends ConsumerWidget {
  const TimeRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(pingEntryColorProvider);

    return switch (ref.watch(timeProvider)) {
      AsyncData(value: final now) => SystemText(
          text: DateFormat('MMMM d, y, h:mma').format(now),
          color: color,
          font: FontEnum.courier,
          size: TextSizeEnum.twelve),
      _ => SizedBox.shrink()
    };
  }
}
