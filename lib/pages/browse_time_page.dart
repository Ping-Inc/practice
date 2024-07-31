import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/components/time_filter_incrementer.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/extensions/time_filter_enum_extensions.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/time_filtered_pings_provider.dart';

class BrowseTimePage extends ConsumerWidget {
  const BrowseTimePage({super.key, required this.timeEnum, required this.time});

  final TimeFilterEnum timeEnum;
  final DateTime time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(timeFilteredPingsProvider(timeEnum, time));

    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(children: [
              TopNav(
                  child: SystemButton(
                onTap: () => context.pop(),
                text: timeEnum.toTitle(),
                icon: PhosphorIcons.caret_left,
              )),
              SystemDivider(),
              TimeFilterIncrementer(
                time: time,
                timeEnum: timeEnum,
              ),
              SystemDivider(),
              Expanded(
                  child: BrowsePage(
                      title: "Test",
                      asyncPings: asyncPings,
                      scroll: () => ref
                          .read(timeFilteredPingsProvider(timeEnum, time)
                              .notifier)
                          .scroll(),
                      count: 1))
            ])));
  }
}
