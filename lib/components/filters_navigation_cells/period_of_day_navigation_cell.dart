import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/extensions/date_time_extensions.dart';
import 'package:practice/extensions/theme_mode_enum_extensions.dart';
import 'package:practice/pages/browse_mode_page.dart';

class PeriodOfDayNavigationCell extends ConsumerWidget {
  const PeriodOfDayNavigationCell({super.key, required this.time});

  final DateTime time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationCell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BrowseModePage(time: time)),
            ),
        label: "Period of Day",
        value: time.themeMode().toTitle());
  }
}
