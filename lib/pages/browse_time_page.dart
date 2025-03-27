import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/enums/month_enum.dart';
import 'package:practice/extensions/date_time_extensions.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/derived_pings_providers.dart';
import 'package:practice/pages/traversal/traversal_scaffold.dart';

class BrowseTimePage extends ConsumerWidget {
  const BrowseTimePage({super.key, required this.timeEnum, required this.time});

  final TimeFilterEnum timeEnum;
  final DateTime time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pings = switch (timeEnum) {
      TimeFilterEnum.dayOfWeek =>
        ref.watch(dayOfWeekFilteredPingsProvider(time.dayOfWeek())),
      TimeFilterEnum.month =>
        ref.watch(monthFilteredPingsProvider(MonthEnum.values[time.month - 1])),
      TimeFilterEnum.dayOfMonth =>
        ref.watch(dayOfMonthFilteredPingsProvider(time.day)),
      TimeFilterEnum.year => ref.watch(yearFilteredPingsProvider(time.year)),
    };

    return TraversalScaffold(
      child: BrowsePage(
        pings: pings,
      ),
    );
  }
}
