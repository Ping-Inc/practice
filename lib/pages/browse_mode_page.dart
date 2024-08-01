import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/components/mode_filter_incrementer.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/mode_filtered_pings_provider.dart';
import 'package:practice/providers/theme_mode_pings_count_provider.dart';

class BrowseModePage extends ConsumerWidget {
  const BrowseModePage({super.key, required this.time});

  final DateTime time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(modeFilteredPingsProvider(time));
    final count = ref.watch(themeModePingsCountProvider(time));

    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(children: [
              TopNav(
                  child: SystemButton(
                onTap: () => context.pop(),
                text: 'Period of Day',
                icon: PhosphorIcons.caret_left,
              )),
              SystemDivider(),
              ModeFilterIncrementer(
                time: time,
              ),
              SystemDivider(),
              Expanded(
                  child: switch (count) {
                AsyncData(value: final countValue) => BrowsePage(
                    asyncPings: asyncPings,
                    scroll: () => ref
                        .read(modeFilteredPingsProvider(time).notifier)
                        .scroll(),
                    count: countValue),
                _ => SizedBox.shrink()
              }),
            ])));
  }
}
