import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/filters_navigation_cells/all_pings_navigation_cell.dart';
import 'package:practice/components/filters_navigation_cells/day_of_month_navigation_cell.dart';
import 'package:practice/components/filters_navigation_cells/day_of_week_navigation_cell.dart';
import 'package:practice/components/filters_navigation_cells/month_navigation_cell%20copy.dart';
import 'package:practice/components/filters_navigation_cells/ping_of_the_day_cell.dart';
import 'package:practice/components/filters_navigation_cells/time_of_day_navigation_cell.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';

class FiltersPage extends ConsumerWidget {
  const FiltersPage({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        controller: controller,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SystemText(text: "Explore", size: TextSizeEnum.thirtySix),
          PingOfTheDayCell(),
          SystemDivider(),
          AllPingsNavigationCell(),
          SystemDivider(),
          TimeOfDayNavigationCell(),
          SystemDivider(),
          DayOfWeekNavigationCell(),
          SystemDivider(),
          DayOfMonthNavigationCell(),
          SystemDivider(),
          MonthNavigationCell(),
        ]));
  }
}
