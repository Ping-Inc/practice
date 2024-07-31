import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/filters_navigation_cells/year_navigation_cell.dart';
import 'package:practice/providers/time_provider.dart';

class CurrentYearNavigationCell extends ConsumerWidget {
  const CurrentYearNavigationCell({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider);

    return switch (time) {
      AsyncData(value: final timeValue) =>
        YearNavigationCell(title: title, time: timeValue),
      _ => SizedBox.shrink()
    };
  }
}
