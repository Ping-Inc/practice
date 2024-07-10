import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/resizing_text_cell.dart';
import 'package:practice/providers/current_ping_provider.dart';

class InputPingTextCell extends ConsumerWidget {
  const InputPingTextCell({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(currentPingProvider);

    return ResizingTextCell(
        text: text,
        color:
            text.isEmpty ? Colors.grey : Theme.of(context).colorScheme.primary);
  }
}
