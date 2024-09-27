import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/ping_replies_provider.dart';
import 'package:practice/providers/replies_to_ping_count_provider.dart';
import 'package:practice/providers/resonated_pings_provider.dart';

class BrowsePingRepliesPage extends ConsumerWidget {
  const BrowsePingRepliesPage(
      {super.key, required this.pingData, required this.sliver});

  final PingData pingData;
  final bool sliver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(pingRepliesProvider(pingData.id!));
    final count = ref.watch(repliesToPingCountProvider(pingData.id!));

    return switch (count) {
      AsyncData(value: final countValue) => BrowsePage(
          sliver: sliver,
          asyncPings: asyncPings,
          scroll: () => ref.read(resonatedPingsProvider.notifier).scroll(),
          count: countValue),
      _ => SliverToBoxAdapter(
          child: SizedBox.shrink(),
        )
    };
  }
}
