import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/pages/browse_ping_replies_page.dart';
import 'package:practice/providers/replies_to_ping_count_provider.dart';

class RepliesToPingNavigationCell extends ConsumerWidget {
  const RepliesToPingNavigationCell({super.key, required this.ping});

  final PingData ping;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(repliesToPingCountProvider(ping.id!));

    return switch (count) {
      AsyncData(value: final countValue) => NavigationCell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BrowsePingRepliesPage(pingData: ping)),
              ),
          label: "Replies",
          value: countValue.toString()),
      _ => SizedBox.shrink()
    };
  }
}
