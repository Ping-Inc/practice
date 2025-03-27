import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/day_of_week_enum.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/extensions/day_of_week_enum_extensions.dart';
import 'package:practice/pages/browse_time_page.dart';
import 'package:practice/pages/explore_page.dart';
import 'package:practice/pages/traversal/traversal_scaffold.dart';

class TraversalDayOfWeekPage extends ConsumerStatefulWidget {
  const TraversalDayOfWeekPage({super.key, required this.time});

  final DateTime time;

  @override
  _TraversalDayOfWeekState createState() => _TraversalDayOfWeekState();
}

class _TraversalDayOfWeekState extends ConsumerState<TraversalDayOfWeekPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = _tabController = TabController(
      initialIndex: widget.time.weekday - 1,
      length: DateTime.daysPerWeek,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TraversalScaffold(
      child: DefaultTabController(
        length: DateTime.daysPerWeek,
        child: ExplorePage(
          tabController: _tabController,
          tabs: DayOfWeekEnum.values.map((filter) {
            return filter.title();
          }).toList(),
          children: DayOfWeekEnum.values.map((day) {
            final now = DateTime.now();
            final selectedDate =
                now.subtract(Duration(days: now.weekday - (day.index + 1)));
            return BrowseTimePage(
              timeEnum: TimeFilterEnum.dayOfWeek,
              time: selectedDate,
            );
          }).toList(),
        ),
      ),
    );
  }
}
