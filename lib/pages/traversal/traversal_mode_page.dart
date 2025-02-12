import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/theme_mode_enum.dart';
import 'package:practice/extensions/theme_mode_enum_extensions.dart';
import 'package:practice/pages/browse_mode_page.dart';
import 'package:practice/pages/explore_page.dart';

class TraversalModePage extends ConsumerStatefulWidget {
  const TraversalModePage({super.key, required this.inputMode});

  final ThemeModeEnum inputMode;

  @override
  _TraversalPageState createState() => _TraversalPageState();
}

class _TraversalPageState extends ConsumerState<TraversalModePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = _tabController = TabController(
      initialIndex: ThemeModeEnum.values.indexOf(widget.inputMode),
      length: ThemeModeEnum.values.length,
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
    return Scaffold(
        body: SafeArea(
      child: DefaultTabController(
        length: ThemeModeEnum.values.length,
        child: ExplorePage(
          tabController: _tabController,
          tabs: ThemeModeEnum.values.map((filter) {
            return filter.title();
          }).toList(),
          children: ThemeModeEnum.values.map((filter) {
            return CustomScrollView(
              slivers: [BrowseModePage(mode: filter)],
            );
          }).toList(),
        ),
      ),
    ));
  }
}
