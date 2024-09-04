import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/time_filtered_pings_provider.dart';
import 'package:practice/providers/time_of_day_pings_count_provider.dart';

class BrowseTimePage extends ConsumerWidget {
  const BrowseTimePage({super.key, required this.timeEnum, required this.time});

  final TimeFilterEnum timeEnum;
  final DateTime time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(timeFilteredPingsProvider(timeEnum, time));
    final count = ref.watch(timeOfDayPingsCountProvider(timeEnum, time));

    return switch (count) {
      AsyncData(value: final countValue) => BrowsePage(
          asyncPings: asyncPings,
          scroll: () => ref
              .read(timeFilteredPingsProvider(timeEnum, time).notifier)
              .scroll(),
          count: countValue),
      _ => SliverToBoxAdapter(
          child: SizedBox.shrink(),
        )
    };
  }
}
