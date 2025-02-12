import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/month_enum.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/extensions/month_enum_extensions.dart';
import 'package:practice/pages/browse_time_page.dart';
import 'package:practice/pages/explore_page.dart';
import 'package:practice/pages/traversal/traversal_scaffold.dart';

class TraversalMonthPage extends ConsumerStatefulWidget {
  const TraversalMonthPage({super.key, required this.month});

  final int month;

  @override
  _TraversalMonthState createState() => _TraversalMonthState();
}

class _TraversalMonthState extends ConsumerState<TraversalMonthPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = _tabController = TabController(
      initialIndex: widget.month - 1,
      length: DateTime.monthsPerYear,
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
        length: DateTime.monthsPerYear,
        child: ExplorePage(
          tabController: _tabController,
          tabs: MonthEnum.values.map((filter) {
            return filter.title();
          }).toList(),
          children: [
            DateTime.january,
            DateTime.february,
            DateTime.march,
            DateTime.april,
            DateTime.may,
            DateTime.june,
            DateTime.july,
            DateTime.august,
            DateTime.september,
            DateTime.october,
            DateTime.november,
            DateTime.december
          ].map((filter) {
            return BrowseTimePage(
              timeEnum: TimeFilterEnum.month,
              time: DateTime(DateTime.now().year, filter),
            );
          }).toList(),
        ),
      ),
    );
  }
}
