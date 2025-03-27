import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/detail_cell.dart';
import 'package:practice/providers/derived_pings_providers.dart';

class ViewCountCell extends ConsumerWidget {
  final int pingId;

  const ViewCountCell({
    super.key,
    required this.pingId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewCount = ref.watch(pingViewCountProvider(pingId));

    return DetailCell(
      title: "${viewCount} visit${viewCount == 1 ? "" : "s"}",
    );
  }
}
