import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/pages/browse_last_week_page.dart';
import 'package:practice/providers/last_week_pings_count_provider.dart';

class OneWeekOldPingsNavigationCell extends ConsumerWidget {
  const OneWeekOldPingsNavigationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(lastWeekPingsCountProvider);

    return switch (count) {
      AsyncData(value: final countValue) => NavigationCell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BrowseLastWeekPage()),
              ),
          label: "Last Week",
          value: countValue.toString()),
      _ => SizedBox.shrink()
    };
  }
}
