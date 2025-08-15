import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/enums/month_enum.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/extensions/month_enum_extensions.dart';
import 'package:practice/pages/browse_time_page.dart';
import 'package:practice/pages/explore_page.dart';
import 'package:practice/pages/traversal/traversal_scaffold.dart';

class TraversalMonthPage extends ConsumerStatefulWidget {
  const TraversalMonthPage({super.key, required this.time});

  final DateTime time;

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
      initialIndex: widget.time.month - 1,
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
          leading: SystemButton(
            onTap: () => Navigator.pop(context),
            icon: PhosphorIcons.caret_left,
          ),
          tabController: _tabController,
          tabs: MonthEnum.values.map((filter) {
            return filter.title();
          }).toList(),
          children: MonthEnum.values.map((month) {
            final selectedDate = DateTime(widget.time.year, month.index + 1);
            return BrowseTimePage(
              timeEnum: TimeFilterEnum.month,
              time: selectedDate,
            );
          }).toList(),
        ),
      ),
    );
  }
}
