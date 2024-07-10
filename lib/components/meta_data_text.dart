import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/providers/current_ping_provider.dart';

class MetaDataText extends ConsumerWidget {
  const MetaDataText({Key? key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPing = ref.watch(currentPingProvider);

    return SystemText(
      text: text,
      color: currentPing.isEmpty
          ? Colors.grey
          : Theme.of(context).colorScheme.primary,
      font: FontEnum.courier,
      size: TextSizeEnum.twelve,
    );
  }
}
