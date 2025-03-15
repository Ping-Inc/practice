import 'package:flutter/material.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:intl/intl.dart';

enum DateCategory { today, yesterday, thisWeek, thisYear, pastYear }

// Class to hold group information
class DateGroup {
  final DateCategory category;
  final DateTime date;
  final String header;
  final List<PingData> pings;

  DateGroup({
    required this.category,
    required this.date,
    required this.header,
    required this.pings,
  });
}

class SystemGrid extends StatelessWidget {
  const SystemGrid({super.key, required this.pings, this.showId = false});

  final List<PingData> pings;
  final bool showId;

  @override
  Widget build(BuildContext context) {
    // Group pings by date category
    List<DateGroup> dateGroups = _groupPingsByDate(pings);

    return CustomScrollView(
      slivers: [
        // Generate sliver sections for each date group
        for (int i = 0; i < dateGroups.length; i++) ...[
          // Header for this date
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: i == 0 ? 0 : spacingMedium,
                bottom: spacingSmall,
              ),
              child: SystemText(
                align: TextAlign.center,
                text: dateGroups[i].header.toLowerCase(),
              ),
            ),
          ),

          // Grid of pings for this date
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: spacingFour,
              crossAxisSpacing: spacingFour,
              childAspectRatio: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final ping = dateGroups[i].pings[index];
                return PingCell(inputPing: ping, showId: showId);
              },
              childCount: dateGroups[i].pings.length,
            ),
          ),
        ],

        // Add bottom padding
        SliverToBoxAdapter(
          child: SizedBox(height: spacingMedium),
        ),
      ],
    );
  }

  // Format date header based on category
  String _formatDateHeader(DateTime date, DateCategory category) {
    final monthAbbr = DateFormat('MMM').format(date);
    final dayOfMonth = date.day.toString();
    final dayOfWeek = DateFormat('EEEE').format(date);

    switch (category) {
      case DateCategory.today:
        return 'today, $monthAbbr $dayOfMonth';
      case DateCategory.yesterday:
        return 'yesterday, $monthAbbr $dayOfMonth';
      case DateCategory.thisWeek:
      case DateCategory.thisYear:
        return '$dayOfWeek, $monthAbbr $dayOfMonth';
      case DateCategory.pastYear:
        return '$dayOfWeek, $monthAbbr $dayOfMonth, ${date.year}';
    }
  }

  // Group pings by date category and return sorted list of DateGroups
  List<DateGroup> _groupPingsByDate(List<PingData> pings) {
    // Setup temporary storage for groups
    final Map<String, DateGroup> groupMap = {};

    // Setup date references
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final startOfWeek = today.subtract(Duration(days: now.weekday - 1));
    final startOfYear = DateTime(now.year);

    // Group pings by date category
    for (final ping in pings) {
      final pingDate = DateTime(
        ping.time.year,
        ping.time.month,
        ping.time.day,
      );

      // Determine category based on date
      DateCategory category;

      if (pingDate.year == today.year &&
          pingDate.month == today.month &&
          pingDate.day == today.day) {
        category = DateCategory.today;
      } else if (pingDate.year == yesterday.year &&
          pingDate.month == yesterday.month &&
          pingDate.day == yesterday.day) {
        category = DateCategory.yesterday;
      } else if (pingDate.isAfter(startOfWeek) && pingDate.isBefore(today)) {
        category = DateCategory.thisWeek;
      } else if (pingDate.isAfter(startOfYear) &&
          pingDate.isBefore(startOfWeek)) {
        category = DateCategory.thisYear;
      } else {
        category = DateCategory.pastYear;
      }

      // Create header based on category
      final header = _formatDateHeader(pingDate, category);

      // Create or add to group
      if (!groupMap.containsKey(header)) {
        groupMap[header] = DateGroup(
          category: category,
          date: pingDate,
          header: header,
          pings: [ping],
        );
      } else {
        groupMap[header]!.pings.add(ping);
      }
    }

    // Convert to list and sort
    List<DateGroup> result = groupMap.values.toList();
    _sortDateGroups(result);

    return result;
  }

  // Sort date groups by category and date
  void _sortDateGroups(List<DateGroup> groups) {
    groups.sort((a, b) {
      // First sort by category priority
      int categoryComparison = a.category.index.compareTo(b.category.index);
      if (categoryComparison != 0) {
        return categoryComparison;
      }

      // If same category, sort by date (most recent first)
      return b.date.compareTo(a.date);
    });
  }
}
