import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/pages/browse_time_page.dart';
import 'package:practice/pages/explore_page.dart';
import 'package:practice/pages/traversal/traversal_scaffold.dart';

class TraversalDayOfMonthPage extends ConsumerStatefulWidget {
  const TraversalDayOfMonthPage({super.key, required this.dayOfMonth});

  final int dayOfMonth;

  @override
  _TraversalDayOfMonthState createState() => _TraversalDayOfMonthState();
}

class _TraversalDayOfMonthState extends ConsumerState<TraversalDayOfMonthPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<int> daysOfMonth = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  ];

  @override
  void initState() {
    super.initState();
    _tabController = _tabController = TabController(
      initialIndex: widget.dayOfMonth - 1,
      length: daysOfMonth.length,
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
          tabs: daysOfMonth.map((filter) {
            return filter.toString();
          }).toList(),
          children: daysOfMonth.map((filter) {
            return BrowseTimePage(
              timeEnum: TimeFilterEnum.dayOfMonth,
              time: DateTime(DateTime.now().year, 1, filter),
            );
          }).toList(),
        ),
      ),
    );
  }
}
