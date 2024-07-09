import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/providers/ping_entry_color_provider.dart';

class NeighborhoodCell extends ConsumerWidget {
  const NeighborhoodCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(pingEntryColorProvider);

    return SystemText(
      text: "neighborhood",
      color: color,
      font: FontEnum.courier,
      size: TextSizeEnum.twelve,
    );
  }
}
