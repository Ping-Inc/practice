import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/extensions/filters_enum_extensions.dart';
import 'package:practice/pages/explore_page.dart';
import 'package:practice/providers/homepage_filters_provider.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/time_provider.dart';

class HomePageExplore extends ConsumerStatefulWidget {
  const HomePageExplore({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<HomePageExplore>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    ref.watch(timeProvider);
    final asyncFilters = ref.watch(homepageFiltersProvider);

    return switch (asyncFilters) {
      AsyncData(value: final filters) => DefaultTabController(
          length: filters.length,
          child: Builder(builder: (context) {
            _tabController?.dispose();
            _tabController = TabController(
                initialIndex: filters.length - 1,
                length: filters.length,
                vsync: this);

            return ExplorePage(
                tabController: _tabController!,
                tabs: filters.map((filter) {
                  return filter.title();
                }).toList(),
                children: filters.map((filter) {
                  return filter.page();
                }).toList());
          }),
        ),
      AsyncError() => SystemText(text: "Error"),
      _ => SystemLoader()
    };
  }
}
