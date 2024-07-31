import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/pings_provider.dart';
import 'package:practice/providers/time_filtered_pings_provider.dart';

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
    final asyncPings =
        ref.watch(timeFilteredPingsProvider(TimeFilterEnum.dayOfMonth, time));

    return NavigationCell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BrowsePage(
                      count: 1,
                      title: title,
                      asyncPings: asyncPings,
                      scroll: () => ref.read(pingsProvider.notifier).scroll())),
            ),
        label: "Day of Month",
        value: getDayWithSuffix(int.parse(DateFormat('d').format(time))));
  }
}
