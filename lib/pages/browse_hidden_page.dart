import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/hidden_pings_count_provider.dart';
import 'package:practice/providers/hidden_pings_provider.dart';

class BrowseHiddenPage extends ConsumerWidget {
  const BrowseHiddenPage({super.key, required this.sliver});

  final bool sliver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(hiddenPingsProvider);
    final count = ref.watch(hiddenPingsCountProvider);

    return switch (count) {
      AsyncData(value: final countValue) => BrowsePage(
          sliver: sliver,
          asyncPings: asyncPings,
          scroll: () => ref.read(hiddenPingsProvider.notifier).scroll(),
          count: countValue),
      _ => sliver
          ? SliverToBoxAdapter(
              child: SizedBox.shrink(),
            )
          : SizedBox.shrink()
    };
  }
}
