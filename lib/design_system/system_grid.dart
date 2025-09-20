import 'package:flutter/material.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/utils/ping_date_utils.dart';

enum DateCategory { today, yesterday, thisYear, pastYear }

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
  const SystemGrid({
    super.key,
    required this.pings,
    this.sortByResonance = false,
    this.sortByPlaced = false,
    required this.shouldRetainScrollPosition
  });

  final List<PingData> pings;
  final bool sortByResonance;
  final bool sortByPlaced;
  final bool shouldRetainScrollPosition;

  @override
  Widget build(BuildContext context) {
    // Group pings by date category
    List<DateGroup> dateGroups = _groupPingsByDate(pings);

    return CustomScrollView(
      key: shouldRetainScrollPosition ? PageStorageKey<String>('ping_search_grid') : null,
      slivers: [
        // Add top padding of 100px
        SliverToBoxAdapter(
          child: SizedBox(height: fadeHeightTop),
        ),

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
                return PingCell(inputPing: ping);
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

  // Group pings by date category and return sorted list of DateGroups
  List<DateGroup> _groupPingsByDate(List<PingData> pings) {
    // Setup temporary storage for groups
    final Map<String, DateGroup> groupMap = {};

    // Group pings by date category
    for (final ping in pings) {
      final DateTime pingDate;
      
      if (sortByResonance && ping.resonantTime != null) {
        pingDate = DateTime(
          ping.resonantTime!.year,
          ping.resonantTime!.month,
          ping.resonantTime!.day,
        );
      } else if (sortByPlaced && ping.placedTime != null) {
        pingDate = DateTime(
          ping.placedTime!.year,
          ping.placedTime!.month,
          ping.placedTime!.day,
        );
      } else {
        pingDate = DateTime(
          ping.time.year,
          ping.time.month,
          ping.time.day,
        );
      }

      // Determine category based on date
      final category = PingDateUtils.getDateCategory(pingDate);

      // Create header based on category
      final header = PingDateUtils.formatForGridHeader(pingDate, category);

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
    PingDateUtils.sortDateGroups(result);

    // Sort pings within each group
    for (var group in result) {
      PingDateUtils.sortPingsByTime(group.pings,
          sortByResonance: sortByResonance, sortByPlaced: sortByPlaced);
    }

    return result;
  }
}
