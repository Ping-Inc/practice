import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/detail_cell.dart';
import 'package:practice/providers/repinged_count_provider.dart';

class RepingedCell extends ConsumerWidget {
  const RepingedCell({super.key, required this.pingId});

  final int pingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repingedCount = ref.watch(repingedCountProvider(pingId));

    return switch (repingedCount) {
      AsyncData(value: final viewCountValue) => viewCountValue == 0
          ? SizedBox.shrink()
          : DetailCell(
              title:
                  "${viewCountValue} re-ping${viewCountValue == 1 ? "" : "s"}",
            ),
      _ => SizedBox.shrink()
    };
  }
}
