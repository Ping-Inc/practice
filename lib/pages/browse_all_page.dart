import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/pings_count_provider.dart';
import 'package:practice/providers/pings_provider.dart';

class BrowseAllPage extends ConsumerWidget {
  const BrowseAllPage({super.key, required this.sliver});

  final bool sliver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(pingsProvider);
    final count = ref.watch(pingsCountProvider);

    return switch (count) {
      AsyncData(value: final countValue) => BrowsePage(
          sliver: sliver,
          asyncPings: asyncPings,
          scroll: () => ref.read(pingsProvider.notifier).scroll(),
          count: countValue),
      _ => sliver
          ? SliverToBoxAdapter(
              child: SizedBox.shrink(),
            )
          : SizedBox.shrink()
    };
  }
}
