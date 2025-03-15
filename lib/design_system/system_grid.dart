import 'package:flutter/material.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:intl/intl.dart';

enum DateCategory { today, yesterday, thisWeek, thisYear, pastYear }

class SystemGrid extends StatelessWidget {
  const SystemGrid({super.key, required this.pings, this.showId = false});

  final List<PingData> pings;
  final bool showId;

  @override
  Widget build(BuildContext context) {
    // Group pings by date category and subgroups
    Map<String, List<PingData>> groupedPings = _groupPingsByDate(pings);

    // Create a list of date headers in order
    List<String> dateHeaders =
        _getOrderedDateHeaders(groupedPings.keys.toList());

    return CustomScrollView(
      slivers: [
        // Generate sliver sections for each date header
        for (final header in dateHeaders) ...[
          // Header for this date
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: header == dateHeaders.first ? 0 : spacingMedium,
                bottom: spacingSmall,
              ),
              child: SystemText(
                align: TextAlign.center,
                text: header.toLowerCase(),
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
                final ping = groupedPings[header]![index];
                return PingCell(inputPing: ping, showId: showId);
              },
              childCount: groupedPings[header]!.length,
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

  // Group pings by date with appropriate headers
  Map<String, List<PingData>> _groupPingsByDate(List<PingData> pings) {
    final Map<String, List<PingData>> grouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final startOfWeek = today.subtract(Duration(days: now.weekday - 1));
    final startOfYear = DateTime(now.year);

    for (final ping in pings) {
      final pingDate = DateTime(
        ping.time.year,
        ping.time.month,
        ping.time.day,
      );

      DateCategory category;
      String header;

      // Compare dates by year, month, day only (not time)
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

      header = _formatDateHeader(pingDate, category);

      if (!grouped.containsKey(header)) {
        grouped[header] = [];
      }

      grouped[header]!.add(ping);
    }

    return grouped;
  }

  // Get date headers in chronological order
  List<String> _getOrderedDateHeaders(List<String> headers) {
    return headers.toList()
      ..sort((a, b) {
        // Keep "today" and "yesterday" at the top
        if (a.startsWith('today')) return -1;
        if (b.startsWith('today')) return 1;
        if (a.startsWith('yesterday')) return -1;
        if (b.startsWith('yesterday')) return 1;

        // For other dates, first check if one has a year and the other doesn't
        final aHasYear = a.split(', ').length > 2;
        final bHasYear = b.split(', ').length > 2;

        // Current year dates (without explicit year) should come before past year dates
        if (aHasYear && !bHasYear) return 1;
        if (!aHasYear && bHasYear) return -1;

        // If both have years or both don't have years, compare chronologically
        final aDate = _parseHeaderDate(a);
        final bDate = _parseHeaderDate(b);
        return bDate.compareTo(aDate); // Most recent first
      });
  }

  DateTime _parseHeaderDate(String header) {
    try {
      // Try parsing with year first
      return DateFormat('EEEE, MMM d, yyyy').parse(header);
    } catch (e) {
      // If that fails, try without year
      try {
        return DateFormat('EEEE, MMM d').parse(header);
      } catch (e) {
        // If all parsing fails, return epoch to put at end
        return DateTime(1970);
      }
    }
  }
}
