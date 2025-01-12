import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/detail_cell.dart';
import 'package:practice/providers/view_count_provider.dart';

class ViewCountCell extends ConsumerWidget {
  const ViewCountCell({super.key, required this.pingId});

  final int pingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewCount = ref.watch(viewCountProvider(pingId));

    return switch (viewCount) {
      AsyncData(value: final viewCountValue) => viewCountValue == 0
          ? SizedBox.shrink()
          : DetailCell(
              title: "${viewCountValue} Visit${viewCountValue == 1 ? "" : "s"}",
            ),
      _ => SizedBox.shrink()
    };
  }
}
