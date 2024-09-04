import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/resonated_pings_count_provider.dart';
import 'package:practice/providers/resonated_pings_provider.dart';

class BrowseResonatedPingsPage extends ConsumerWidget {
  const BrowseResonatedPingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(resonatedPingsProvider);
    final count = ref.watch(resonatedPingsCountProvider);

    return switch (count) {
      AsyncData(value: final countValue) => BrowsePage(
          asyncPings: asyncPings,
          scroll: () => ref.read(resonatedPingsProvider.notifier).scroll(),
          count: countValue),
      _ => SliverToBoxAdapter(
          child: SizedBox.shrink(),
        )
    };
  }
}
