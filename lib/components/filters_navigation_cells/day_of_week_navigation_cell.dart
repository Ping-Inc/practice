import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/pings_provider.dart';
import 'package:practice/providers/time_filtered_pings_provider.dart';

class DayOfWeekNavigationCell extends ConsumerWidget {
  const DayOfWeekNavigationCell(
      {super.key, required this.title, required this.time});

  final String title;
  final DateTime time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings =
        ref.watch(timeFilteredPingsProvider(TimeFilterEnum.dayOfWeek, time));

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
        label: "Day of Week",
        value: DateFormat('EEEE').format(time));
  }
}
