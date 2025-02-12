import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/ping_replies_provider.dart';
import 'package:practice/providers/resonated_pings_provider.dart';

class BrowsePingRepliesPage extends ConsumerWidget {
  const BrowsePingRepliesPage({super.key, required this.pingData});

  final PingData pingData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BrowsePage(
      asyncPings: ref.watch(pingRepliesProvider(pingData.id!)),
      scroll: () => ref.read(resonatedPingsProvider.notifier).scroll(),
    );
  }
}
