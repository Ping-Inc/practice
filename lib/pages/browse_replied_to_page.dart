import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/pings_with_replies_count_provider.dart';
import 'package:practice/providers/replied_to_pings_provider.dart';

class BrowseRepliedToPage extends ConsumerWidget {
  const BrowseRepliedToPage({super.key, required this.sliver});

  final bool sliver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(repliedToPingsProvider);
    final count = ref.watch(pingsWithRepliesCountProvider);

    return switch (count) {
      AsyncData(value: final countValue) => BrowsePage(
          sliver: sliver,
          asyncPings: asyncPings,
          scroll: () => ref.read(repliedToPingsProvider.notifier).scroll(),
          count: countValue),
      _ => sliver
          ? SliverToBoxAdapter(
              child: SizedBox.shrink(),
            )
          : SizedBox.shrink()
    };
  }
}
