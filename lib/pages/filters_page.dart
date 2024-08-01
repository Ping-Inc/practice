import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/filters_navigation_cells/all_pings_navigation_cell.dart';
import 'package:practice/components/filters_navigation_cells/current_day/current_day_of_month_navigation_cell.dart';
import 'package:practice/components/filters_navigation_cells/current_day/current_day_of_week_navigation_cell.dart';
import 'package:practice/components/filters_navigation_cells/current_day/current_month_navigation_cell%20copy.dart';
import 'package:practice/components/filters_navigation_cells/current_day/current_period_of_day_navigation_cell.dart';
import 'package:practice/components/filters_navigation_cells/ping_of_the_day_cell.dart';
import 'package:practice/components/navigation_cell_cluster.dart';
import 'package:practice/components/page_with_header.dart';

class FiltersPage extends ConsumerWidget {
  const FiltersPage({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        controller: controller,
        child: PageWithHeader(
            title: "Explore",
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              NavigationCellCluster(title: "Ping of the day", children: [
                PingOfTheDayCell(),
              ]),
              NavigationCellCluster(title: "Browse", children: [
                AllPingsNavigationCell(),
              ]),
              NavigationCellCluster(title: "Current Time", children: [
                CurrentPeriodOfDayNavigationCell(title: "Period of Day"),
                CurrentDayOfWeekNavigationCell(),
                CurrentMonthNavigationCell(),
                CurrentDayOfMonthNavigationCell(),
              ]),
            ])));
  }
}
