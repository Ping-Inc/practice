import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/pages/browse_time_page.dart';
import 'package:practice/pages/explore_page.dart';
import 'package:practice/pages/traversal/traversal_scaffold.dart';

class TraversalYearPagePostFetch extends ConsumerStatefulWidget {
  const TraversalYearPagePostFetch(
      {super.key, required this.year, required this.years});

  final int year;
  final List<int> years;

  @override
  _TraversalYearPagePostFetchState createState() =>
      _TraversalYearPagePostFetchState();
}

class _TraversalYearPagePostFetchState
    extends ConsumerState<TraversalYearPagePostFetch>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = _tabController = TabController(
      initialIndex: widget.years.indexWhere((year) => year == widget.year),
      length: widget.years.length,
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
          tabs: widget.years.map((filter) {
            return filter.toString();
          }).toList(),
          children: widget.years.map((filter) {
            return BrowseTimePage(
              timeEnum: TimeFilterEnum.year,
              time: DateTime(filter),
            );
          }).toList(),
        ),
      ),
    );
  }
}
