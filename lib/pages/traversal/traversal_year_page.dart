import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/pages/browse_time_page.dart';
import 'package:practice/pages/explore_page.dart';
import 'package:practice/pages/traversal/traversal_scaffold.dart';
import 'package:practice/providers/derived_pings_providers.dart';

class TraversalYearPage extends ConsumerStatefulWidget {
  const TraversalYearPage({super.key, required this.year});

  final int year;

  @override
  _TraversalYearState createState() => _TraversalYearState();
}

class _TraversalYearState extends ConsumerState<TraversalYearPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<int> _years = [];

  @override
  void initState() {
    super.initState();
    _years = ref.read(pingYearsProvider);
    _tabController = TabController(
      initialIndex: _years.indexWhere((year) => year == widget.year),
      length: _years.length,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(TraversalYearPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newYears = ref.read(pingYearsProvider);
    if (newYears != _years) {
      _years = newYears;
      _tabController.dispose();
      _tabController = TabController(
        initialIndex: _years.indexWhere((year) => year == widget.year),
        length: _years.length,
        vsync: this,
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final years = ref.watch(pingYearsProvider);
    return TraversalScaffold(
      child: DefaultTabController(
        length: years.length,
        child: ExplorePage(
          backArrow: SystemButton(
            onTap: () => Navigator.pop(context),
            icon: PhosphorIcons.caret_left,
          ),
          tabController: _tabController,
          tabs: years.map((year) => year.toString()).toList(),
          children: years.map((year) {
            return BrowseTimePage(
              timeEnum: TimeFilterEnum.year,
              time: DateTime(year),
            );
          }).toList(),
        ),
      ),
    );
  }
}
