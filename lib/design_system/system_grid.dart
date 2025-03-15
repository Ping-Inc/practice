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
    // Group pings by date category
    Map<DateCategory, List<PingData>> groupedPings =
        _groupPingsByDateCategory(pings);

    // Create a list of date categories in order
    List<DateCategory> dateCategories =
        _getOrderedDateCategories(groupedPings.keys.toList());

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification &&
            FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
        return true;
      },
      child: CustomScrollView(
        slivers: [
          // Generate sliver sections for each date category
          for (final category in dateCategories) ...[
            // Header for this date category
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  top: category == dateCategories.first ? 0 : spacingMedium,
                  bottom: spacingSmall,
                ),
                child: SystemText(
                  align: TextAlign.center,
                  text: _formatCategoryHeader(category).toLowerCase(),
                ),
              ),
            ),

            // Grid of pings for this category
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: spacingFour,
                crossAxisSpacing: spacingFour,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final ping = groupedPings[category]![index];
                  return PingCell(inputPing: ping, showId: showId);
                },
                childCount: groupedPings[category]!.length,
              ),
            ),
          ],

          // Add bottom padding
          SliverToBoxAdapter(
            child: SizedBox(height: spacingMedium),
          ),
        ],
      ),
    );
  }

  String _formatCategoryHeader(DateCategory category) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final monthAbbr = DateFormat('MMM').format(now);
    final dayOfMonth = now.day.toString();

    switch (category) {
      case DateCategory.today:
        return 'today, $monthAbbr $dayOfMonth';
      case DateCategory.yesterday:
        final yesterday = today.subtract(const Duration(days: 1));
        final yesterdayMonth = DateFormat('MMM').format(yesterday);
        final yesterdayDay = yesterday.day.toString();
        return 'yesterday, $yesterdayMonth $yesterdayDay';
      case DateCategory.thisWeek:
      case DateCategory.thisYear:
        return DateFormat('EEEE, MMM d').format(now);
      case DateCategory.pastYear:
        return DateFormat('EEEE, MMM d, y').format(now);
    }
  }

  // Group pings by date category
  Map<DateCategory, List<PingData>> _groupPingsByDateCategory(
      List<PingData> pings) {
    final Map<DateCategory, List<PingData>> grouped = {};
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

      if (pingDate.isAtSameMomentAs(today)) {
        category = DateCategory.today;
      } else if (pingDate.isAtSameMomentAs(yesterday)) {
        category = DateCategory.yesterday;
      } else if (pingDate.isAfter(startOfWeek) ||
          pingDate.isAtSameMomentAs(startOfWeek)) {
        category = DateCategory.thisWeek;
      } else if (pingDate.isAfter(startOfYear) ||
          pingDate.isAtSameMomentAs(startOfYear)) {
        category = DateCategory.thisYear;
      } else {
        category = DateCategory.pastYear;
      }

      if (!grouped.containsKey(category)) {
        grouped[category] = [];
      }

      grouped[category]!.add(ping);
    }

    return grouped;
  }

  // Get date categories in a logical order
  List<DateCategory> _getOrderedDateCategories(List<DateCategory> categories) {
    return categories.toList()
      ..sort((a, b) {
        // Categories are already ordered by enum definition
        return a.index.compareTo(b.index);
      });
  }
}
