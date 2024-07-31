import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/filters_navigation_cells/period_of_day_navigation_cell.dart';

import 'package:practice/providers/time_provider.dart';

class CurrentPeriodOfDayNavigationCell extends ConsumerWidget {
  const CurrentPeriodOfDayNavigationCell({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider);

    return switch (time) {
      AsyncData(value: final timeValue) =>
        PeriodOfDayNavigationCell(title: title, time: timeValue),
      _ => SizedBox.shrink()
    };
  }
}
