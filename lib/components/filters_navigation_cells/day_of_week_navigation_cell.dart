import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/pages/browse_page.dart';

class DayOfWeekNavigationCell extends ConsumerWidget {
  const DayOfWeekNavigationCell(
      {super.key, required this.title, required this.time});

  final String title;
  final DateTime time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationCell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BrowsePage(title: title)),
            ),
        label: "Day of Week",
        value: DateFormat('EEEE').format(time));
  }
}
