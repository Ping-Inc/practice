import 'package:flutter/material.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/lens_date.dart';
import 'package:practice/utils/ping_date_utils.dart';

enum DateCategory { today, yesterday, thisYear, pastYear }

// Class to hold group information
class DateGroup {
  final DateCategory category;
  final DateTime date;
  final List<PingData> pings;

  // Worked out only when the heading is shown (formatting dates is slow, and
  // a lens can span thousands of days).
  late final String header = PingDateUtils.formatForGridHeader(date, category);

  DateGroup({
    required this.category,
    required this.date,
    required this.pings,
  });
}

class SystemGrid extends StatelessWidget {
  const SystemGrid(
      {super.key,
      required this.pings,
      this.lensDate = LensDate.captured,
      required this.shouldRetainScrollPosition});

  final List<PingData> pings;
  final LensDate lensDate;
  final bool shouldRetainScrollPosition;

  @override
  Widget build(BuildContext context) {
    // Group pings by date category
    final dateGroups = _groupPingsByDate(pings);
    final rows = _rowsFor(dateGroups);

    // One lazy list of rows (a day's heading, or two pings side by side), so
    // only the rows on screen are built, however many pings there are.
    return CustomScrollView(
      key: shouldRetainScrollPosition
          ? PageStorageKey<String>('ping_search_grid')
          : null,
      slivers: [
        // Add top padding of 100px
        SliverToBoxAdapter(
          child: SizedBox(height: fadeHeightTop),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final row = rows[index];
              final group = dateGroups[row.group];

              // Header for this date
              if (row.first == null) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: row.group == 0 ? 0 : spacingMedium,
                    bottom: spacingSmall,
                  ),
                  child: SystemText(
                    align: TextAlign.center,
                    text: group.header.toLowerCase(),
                  ),
                );
              }

              // Two square cells, spaced like the grid this replaces.
              final first = row.first!;
              final isLastRow = first + 2 >= group.pings.length;
              Widget cell(int i) => Expanded(
                    child: i < group.pings.length
                        ? AspectRatio(
                            aspectRatio: 1,
                            child: PingCell(inputPing: group.pings[i]),
                          )
                        : const SizedBox.shrink(),
                  );
              return Padding(
                padding: EdgeInsets.only(bottom: isLastRow ? 0 : spacingFour),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cell(first),
                    SizedBox(width: spacingFour),
                    cell(first + 1),
                  ],
                ),
              );
            },
            childCount: rows.length,
          ),
        ),

        // Add bottom padding
        SliverToBoxAdapter(
          child: SizedBox(height: spacingMedium),
        ),
      ],
    );
  }

  // The list's rows: each day's heading, then its pings two to a row.
  List<({int group, int? first})> _rowsFor(List<DateGroup> groups) {
    final rows = <({int group, int? first})>[];
    for (int g = 0; g < groups.length; g++) {
      rows.add((group: g, first: null));
      for (int i = 0; i < groups[g].pings.length; i += 2) {
        rows.add((group: g, first: i));
      }
    }
    return rows;
  }

  // Group pings by day and return sorted list of DateGroups
  List<DateGroup> _groupPingsByDate(List<PingData> pings) {
    // Group by day, keyed by a plain number (20261027): making a date for
    // every ping is slow with thousands of them.
    final Map<int, List<PingData>> byDay = {};
    for (final ping in pings) {
      final date = lensDate.of(ping);
      final key = date.year * 10000 + date.month * 100 + date.day;
      (byDay[key] ??= []).add(ping);
    }

    // Each day's category, against today worked out once.
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final startOfYear = DateTime(now.year);

    final List<DateGroup> result = [];
    byDay.forEach((key, dayPings) {
      final date = DateTime(key ~/ 10000, key ~/ 100 % 100, key % 100);
      result.add(DateGroup(
        category: PingDateUtils.dateCategoryOf(date,
            today: today, yesterday: yesterday, startOfYear: startOfYear),
        date: date,
        pings: dayPings,
      ));
    });
    PingDateUtils.sortDateGroups(result);

    // Sort pings within each group
    for (var group in result) {
      PingDateUtils.sortPingsByTime(group.pings, lensDate: lensDate);
    }

    return result;
  }
}
