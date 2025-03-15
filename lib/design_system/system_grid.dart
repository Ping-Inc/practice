import 'package:flutter/material.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:intl/intl.dart';

class SystemGrid extends StatelessWidget {
  const SystemGrid({super.key, required this.pings, this.showId = false});

  final List<PingData> pings;
  final bool showId;

  @override
  Widget build(BuildContext context) {
    // Group pings by date category
    final groupedPings = _groupPingsByDate();

    // Sort headers chronologically (most recent first)
    final dateHeaders = groupedPings.keys.toList()
      ..sort((a, b) => _compareHeaders(a, b));

    return CustomScrollView(
      slivers: [
        for (final header in dateHeaders) ...[
          // Date header
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

          // Grid for this date group
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: spacingFour,
              crossAxisSpacing: spacingFour,
              childAspectRatio: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => PingCell(
                  inputPing: groupedPings[header]![index], showId: showId),
              childCount: groupedPings[header]!.length,
            ),
          ),
        ],

        // Bottom padding
        SliverToBoxAdapter(child: SizedBox(height: spacingMedium)),
      ],
    );
  }

  // Group pings by date with appropriate headers
  Map<String, List<PingData>> _groupPingsByDate() {
    final Map<String, List<PingData>> grouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final startOfWeek = today.subtract(Duration(days: now.weekday - 1));
    final startOfYear = DateTime(now.year);

    final monthFormat = DateFormat('MMM');
    final dayOfWeekFormat = DateFormat('EEEE');

    for (final ping in pings) {
      final pingDate = DateTime(
        ping.time.year,
        ping.time.month,
        ping.time.day,
      );

      // Create appropriate header based on date
      final String header;
      final monthDay = '${monthFormat.format(pingDate)} ${pingDate.day}';

      if (pingDate == today) {
        header = 'today, $monthDay';
      } else if (pingDate == yesterday) {
        header = 'yesterday, $monthDay';
      } else if (pingDate.isAfter(startOfWeek) ||
          pingDate.isAtSameMomentAs(startOfWeek)) {
        header = '${dayOfWeekFormat.format(pingDate)}, $monthDay';
      } else if (pingDate.isAfter(startOfYear) ||
          pingDate.isAtSameMomentAs(startOfYear)) {
        header = '${dayOfWeekFormat.format(pingDate)}, $monthDay';
      } else {
        header =
            '${dayOfWeekFormat.format(pingDate)}, $monthDay, ${pingDate.year}';
      }

      // Add ping to its group
      (grouped[header] ??= []).add(ping);
    }

    return grouped;
  }

  // Compare headers for sorting (most recent first)
  int _compareHeaders(String a, String b) {
    // Special handling for today/yesterday
    if (a.startsWith('today')) return -1;
    if (b.startsWith('today')) return 1;
    if (a.startsWith('yesterday')) return -1;
    if (b.startsWith('yesterday')) return 1;

    // Extract dates from headers
    final aDate = _extractDateFromHeader(a);
    final bDate = _extractDateFromHeader(b);

    // Most recent first
    return bDate.compareTo(aDate);
  }

  // Extract date from header text
  DateTime _extractDateFromHeader(String header) {
    // Remove day name prefix and any "today"/"yesterday" text
    final parts = header.split(', ');
    if (parts.length < 2) return DateTime(1970);

    String dateText = parts.length > 1 ? parts[1] : parts[0];

    // Try to parse with year if present
    if (parts.length > 2) {
      try {
        return DateFormat('MMM d, yyyy').parse('$dateText, ${parts[2]}');
      } catch (_) {}
    }

    // Try without year
    try {
      return DateFormat('MMM d').parse(dateText);
    } catch (_) {
      return DateTime(1970); // Fallback
    }
  }
}
