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
  List<LensItem>? _previousFilters;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    ref.watch(timeProvider);
    final asyncFilters = ref.watch(homepageFiltersProvider);

    if (asyncFilters.hasValue && asyncFilters.value != null) {
      final filters = asyncFilters.value!;
      return DefaultTabController(
          length: filters.length,
          child: Builder(builder: (context) {
            if (_tabController == null || _tabController!.length != filters.length) {
              int initialIndex = filters.length - 1;

              if (_tabController != null && _previousFilters != null) {
                final previousIndex = _tabController!.index;
                if (previousIndex >= 0 && previousIndex < _previousFilters!.length) {
                  final activeLens = _previousFilters![previousIndex];
                  final newIndex = filters.indexOf(activeLens);
                  if (newIndex != -1) {
                    initialIndex = newIndex;
                  }
                }
                _tabController!.dispose();
              }

              _tabController = TabController(
                  initialIndex: initialIndex,
                  length: filters.length,
                  vsync: this);
            }
            
            _previousFilters = filters;

            return ExplorePage(
                tabController: _tabController!,
                tabs: filters.map((filter) {
                  return filter.title();
                }).toList(),
                children: filters.map((filter) {
                  return filter.page();
                }).toList());
          }),
        );
    } else if (asyncFilters.hasError) {
      return SystemText(text: "Error");
    } else {
      return SystemLoader();
    }
  }
}
