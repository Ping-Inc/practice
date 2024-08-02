import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/hidden_pings_count_provider.dart';
import 'package:practice/providers/hidden_pings_provider.dart';

class BrowseHiddenPage extends ConsumerWidget {
  const BrowseHiddenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(hiddenPingsProvider);
    final count = ref.watch(hiddenPingsCountProvider);

    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(children: [
              TopNav(
                  child: SystemButton(
                onTap: () => context.pop(),
                text: 'Hidden',
                icon: PhosphorIcons.caret_left,
              )),
              SystemDivider(),
              Expanded(
                  child: switch (count) {
                AsyncData(value: final countValue) => BrowsePage(
                    asyncPings: asyncPings,
                    scroll: () =>
                        ref.read(hiddenPingsProvider.notifier).scroll(),
                    count: countValue),
                _ => SizedBox.shrink()
              }),
            ])));
  }
}
