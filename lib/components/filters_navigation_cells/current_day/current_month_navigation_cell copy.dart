import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/filters_navigation_cells/month_navigation_cell.dart';
import 'package:practice/providers/current_month_provider.dart';

class CurrentMonthNavigationCell extends ConsumerWidget {
  const CurrentMonthNavigationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(currentMonthProvider);

    return switch (time) {
      AsyncData(value: final timeValue) => MonthNavigationCell(time: timeValue),
      _ => SizedBox.shrink()
    };
  }
}
