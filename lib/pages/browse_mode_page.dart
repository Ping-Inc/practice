import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/mode_filtered_pings_provider.dart';
import 'package:practice/providers/theme_mode_pings_count_provider.dart';

class BrowseModePage extends ConsumerWidget {
  const BrowseModePage({super.key, required this.time, required this.sliver});

  final DateTime time;
  final bool sliver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(modeFilteredPingsProvider(time));
    final count = ref.watch(themeModePingsCountProvider(time));

    return switch (count) {
      AsyncData(value: final countValue) => BrowsePage(
          sliver: sliver,
          asyncPings: asyncPings,
          scroll: () =>
              ref.read(modeFilteredPingsProvider(time).notifier).scroll(),
          count: countValue),
      _ => sliver
          ? SliverToBoxAdapter(
              child: SizedBox.shrink(),
            )
          : SizedBox.shrink()
    };
  }
}
