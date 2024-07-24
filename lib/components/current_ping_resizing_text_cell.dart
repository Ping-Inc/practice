import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/resizing_text.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/providers/current_ping_provider.dart';

class CurrentPingResizingTextCell extends ConsumerWidget {
  const CurrentPingResizingTextCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(currentPingProvider);

    return text.isEmpty
        ? Center(
            child: SystemText(
            text: "type..",
            color: Colors.grey,
            size: TextSizeEnum.twentyNine,
          ))
        : Padding(
            padding: EdgeInsets.all(spacingFive),
            child: ResizingText(text: text.isEmpty ? "type.." : text));
  }
}
