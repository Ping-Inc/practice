import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/ping_replies_provider.dart';
import 'package:practice/providers/replies_to_ping_count_provider.dart';
import 'package:practice/providers/resonated_pings_provider.dart';

class BrowsePingRepliesPage extends ConsumerWidget {
  const BrowsePingRepliesPage({super.key, required this.pingData});

  final PingData pingData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(pingRepliesProvider(pingData.id!));
    final count = ref.watch(repliesToPingCountProvider(pingData.id!));

    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(children: [
              TopNav(
                  child: SystemButton(
                onTap: () => context.pop(),
                text: "\"${pingData.text}\"",
                icon: PhosphorIcons.caret_left,
              )),
              SystemDivider(),
              Expanded(
                  child: switch (count) {
                AsyncData(value: final countValue) => BrowsePage(
                    asyncPings: asyncPings,
                    scroll: () =>
                        ref.read(resonatedPingsProvider.notifier).scroll(),
                    count: countValue),
                _ => SizedBox.shrink()
              }),
            ])));
  }
}
