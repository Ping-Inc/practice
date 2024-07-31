import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/filters_navigation_cells/day_of_month_navigation_cell.dart';
import 'package:practice/providers/time_provider.dart';

class CurrentDayOfMonthNavigationCell extends ConsumerWidget {
  const CurrentDayOfMonthNavigationCell({super.key, required this.title});

  final String title;

  String getDayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider);

    return switch (time) {
      AsyncData(value: final timeValue) =>
        DayOfMonthNavigationCell(title: title, time: timeValue),
      _ => SizedBox.shrink()
    };
  }
}
