import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/resizing_text_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/current_ping_provider.dart';

class CurrentPingCell extends ConsumerWidget {
  const CurrentPingCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.all(spacingEight),
        child: AspectRatio(
            aspectRatio: 1,
            child: ResizingTextCell(text: ref.watch(currentPingProvider))));
  }
}
