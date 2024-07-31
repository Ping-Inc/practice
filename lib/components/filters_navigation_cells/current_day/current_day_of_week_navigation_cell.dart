import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/filters_navigation_cells/day_of_week_navigation_cell.dart';
import 'package:practice/providers/time_provider.dart';

class CurrentDayOfWeekNavigationCell extends ConsumerWidget {
  const CurrentDayOfWeekNavigationCell({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider);

    return switch (time) {
      AsyncData(value: final timeValue) =>
        DayOfWeekNavigationCell(title: title, time: timeValue),
      _ => SizedBox.shrink()
    };
  }
}
