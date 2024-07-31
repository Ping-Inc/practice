import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/pages/browse_page.dart';

class DayOfMonthNavigationCell extends ConsumerWidget {
  const DayOfMonthNavigationCell(
      {super.key, required this.title, required this.time});

  final String title;
  final DateTime time;

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
    return NavigationCell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BrowsePage(title: title)),
            ),
        label: "Day of Month",
        value: getDayWithSuffix(int.parse(DateFormat('d').format(time))));
  }
}
