import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/pings_provider.dart';

class BrowseAllPage extends ConsumerWidget {
  const BrowseAllPage({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(pingsProvider);

    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(children: [
              TopNav(
                  child: SystemButton(
                onTap: () => context.pop(),
                text: "All Pings",
                icon: PhosphorIcons.caret_left,
              )),
              SystemDivider(),
              Expanded(
                  child: BrowsePage(
                      title: "Test",
                      asyncPings: asyncPings,
                      scroll: () => ref.read(pingsProvider.notifier).scroll(),
                      count: count))
            ])));
  }
}
