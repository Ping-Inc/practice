import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/detail_cell.dart';
import 'package:practice/providers/derived_pings_providers.dart' as derived;

class RepingedCell extends ConsumerWidget {
  const RepingedCell({super.key, required this.pingId});

  final int pingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repingedCount = ref.watch(derived.pingResonanceCountProvider(pingId));

    return repingedCount == 0
        ? SizedBox.shrink()
        : DetailCell(
            title: "$repingedCount re-ping${repingedCount == 1 ? "" : "s"}",
          );
  }
}
