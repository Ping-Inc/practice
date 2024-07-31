import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/extensions/date_time_extensions.dart';
import 'package:practice/extensions/theme_mode_enum_extensions.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/pings_provider.dart';

class PeriodOfDayNavigationCell extends ConsumerWidget {
  const PeriodOfDayNavigationCell(
      {super.key, required this.title, required this.time});

  final String title;
  final DateTime time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPings = ref.watch(pingsProvider);

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
        label: "Period of Day",
        value: time.themeMode().toTitle());
  }
}
