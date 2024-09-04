import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/extensions/filters_enum_extensions.dart';
import 'package:practice/pages/new_ping_page.dart';
import 'package:practice/pages/search_page.dart';
import 'package:practice/pages/settings_page.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FiltersEnum.values.length, vsync: this);
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
        child: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                length: FiltersEnum.values.length,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        floating: true,
                        pinned: false,
                        snap: true,
                        backgroundColor: Theme.of(context)
                            .scaffoldBackgroundColor, // Make the background transparent
                        toolbarHeight:
                            spacingFour, // Remove the unused top area
                        bottom: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(),
                          isScrollable: true,
                          dividerColor:
                              Colors.transparent, // Remove the divider color
                          splashFactory:
                              NoSplash.splashFactory, // Remove splash effect
                          labelColor: Theme.of(context).colorScheme.primary,
                          unselectedLabelColor:
                              Theme.of(context).colorScheme.secondary,
                          tabs: FiltersEnum.values.map((filter) {
                            return Text(filter.title(),
                                style: TextStyle(fontSize: 28));
                          }).toList(),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: FiltersEnum.values.map((filter) {
                      return CustomScrollView(
                        slivers: [
                          filter.page(DateTime.now()),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SystemTap(
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        ),
                    child: SizedBox(
                        height: tapTarget,
                        width: tapTarget,
                        child: Center(
                            child: Icon(PhosphorIcons.magnifying_glass,
                                size: 34)))),
                SystemTap(
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewPingPage()),
                        ),
                    child: Icon(PhosphorIcons.circle_fill, size: 72)),
                SystemTap(
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()),
                        ),
                    child: SizedBox(
                        height: tapTarget,
                        width: tapTarget,
                        child:
                            Center(child: Icon(PhosphorIcons.gear, size: 34)))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
