import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/extensions/filters_enum_extensions.dart';
import 'package:practice/extensions/font_enum_extensions.dart';

class ExplorePage extends ConsumerWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: FiltersEnum.values.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                floating: true,
                pinned: false,
                snap: false,
                backgroundColor:
                    Colors.transparent, // Make the background transparent
                toolbarHeight: spacingFour,
                bottom: TabBar(
                  indicator: BoxDecoration(),
                  isScrollable: true,
                  dividerHeight: 0,
                  splashFactory: NoSplash.splashFactory,
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                  tabs: FiltersEnum.values.map((filter) {
                    return Text(filter.title(),
                        style: TextStyle(
                            fontSize: 28,
                            fontFamily: FontEnum.sfpro.toFontFamily()));
                  }).toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: FiltersEnum.values.map((filter) {
              return filter.page(DateTime.now());
            }).toList(),
          ),
        ),
      ),
    );

    // return SingleChildScrollView(
    //     controller: controller,
    //     child: PageWithHeader(
    //         title: "Explore",
    //         child:
    //             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //           NavigationCellCluster(title: "Ping of the day", children: [
    //             PingOfTheDayCell(),
    //           ]),
    //           NavigationCellCluster(title: "Browse", children: [
    //             AllPingsNavigationCell(),
    //             PingsWithRepliesNavigationCell(),
    //             UnviewedPingsNavigationCell(),
    //             ResonantPingsNavigationCell()
    //           ]),
    //           NavigationCellCluster(title: "Current Time", children: [
    //             CurrentPeriodOfDayNavigationCell(title: "Period of Day"),
    //             CurrentDayOfWeekNavigationCell(),
    //             CurrentMonthNavigationCell(),
    //             CurrentDayOfMonthNavigationCell(),
    //           ]),
    //           NavigationCellCluster(title: "Past Time", children: [
    //             OneWeekOldPingsNavigationCell(),
    //           ]),
    //           NavigationCellCluster(title: "Sensitive", children: [
    //             HiddenPingsNavigationCell(),
    //           ]),
    //         ])));
  }
}
