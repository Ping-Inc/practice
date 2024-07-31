import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/filters_navigation_cells/year_navigation_cell.dart';
import 'package:practice/providers/current_year_provider.dart';

class CurrentYearNavigationCell extends ConsumerWidget {
  const CurrentYearNavigationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(currentYearProvider);

    return switch (time) {
      AsyncData(value: final timeValue) => YearNavigationCell(time: timeValue),
      _ => SizedBox.shrink()
    };
  }
}
