import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/pages/browse_page.dart';

class MonthNavigationCell extends ConsumerWidget {
  const MonthNavigationCell(
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
        label: "Month",
        value: DateFormat('MMMM').format(time));
  }
}
