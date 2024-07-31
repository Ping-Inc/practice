import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/filters_navigation_cells/day_of_week_navigation_cell.dart';
import 'package:practice/providers/current_day_of_week_provider.dart';

class CurrentDayOfWeekNavigationCell extends ConsumerWidget {
  const CurrentDayOfWeekNavigationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(currentDayOfWeekProvider);

    return switch (time) {
      AsyncData(value: final timeValue) =>
        DayOfWeekNavigationCell(time: timeValue),
      _ => SizedBox.shrink()
    };
  }
}
