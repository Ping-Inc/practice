import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/never_visited_pings_provider.dart';
import 'package:practice/providers/unviewed_pings_count_provider.dart';

class BrowseNeverVisitedPage extends ConsumerWidget {
  const BrowseNeverVisitedPage({super.key, required this.sliver});

  final bool sliver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(neverVisitedPingsProvider);
    final count = ref.watch(unviewedPingsCountProvider);

    return switch (count) {
      AsyncData(value: final countValue) => BrowsePage(
          sliver: sliver,
          asyncPings: asyncPings,
          scroll: () => ref.read(neverVisitedPingsProvider.notifier).scroll(),
          count: countValue),
      _ => sliver
          ? SliverToBoxAdapter(
              child: SizedBox.shrink(),
            )
          : SizedBox.shrink()
    };
  }
}
