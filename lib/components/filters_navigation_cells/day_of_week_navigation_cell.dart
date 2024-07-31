import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/time_provider.dart';

class DayOfWeekNavigationCell extends ConsumerWidget {
  const DayOfWeekNavigationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider);

    return switch (time) {
      AsyncData(value: final timeValue) => NavigationCell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BrowsePage()),
              ),
          label: "Day of Week",
          value: DateFormat('EEEE').format(timeValue)),
      _ => SizedBox.shrink()
    };
  }
}
