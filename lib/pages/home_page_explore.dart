import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/extensions/filters_enum_extensions.dart';
import 'package:practice/pages/explore_page.dart';
import 'package:practice/providers/current_day_of_week_provider.dart';
import 'package:practice/providers/homepage_filters_provider.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/design_system/system_text.dart';

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
    ref.watch(currentDayOfWeekProvider);
    final currentTime = DateTime.now();
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
                  return filter.title(currentTime);
                }).toList(),
                children: filters.map((filter) {
                  return filter.page(currentTime);
                }).toList());
          }),
        ),
      AsyncError() => SystemText(text: "Erro"),
      _ => SystemLoader()
    };
  }
}
