import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/time_provider.dart';

class MonthNavigationCell extends ConsumerWidget {
  const MonthNavigationCell({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider);

    return switch (time) {
      AsyncData(value: final timeValue) => NavigationCell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BrowsePage(title: title)),
              ),
          label: "Month",
          value: DateFormat('MMMM').format(timeValue)),
      _ => SizedBox.shrink()
    };
  }
}
