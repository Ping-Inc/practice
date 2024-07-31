import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/filters_navigation_cells/day_of_month_navigation_cell.dart';
import 'package:practice/components/filters_navigation_cells/day_of_week_navigation_cell.dart';
import 'package:practice/components/filters_navigation_cells/month_navigation_cell.dart';
import 'package:practice/components/filters_navigation_cells/period_of_day_navigation_cell.dart';
import 'package:practice/components/filters_navigation_cells/year_navigation_cell.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/components/navigation_cell_cluster.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';

class DetailsPage extends ConsumerWidget {
  const DetailsPage({super.key, required this.ping, required this.title});

  final Ping ping;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                TopNav(
                  child: SystemButton(
                      onTap: () => Navigator.pop(context),
                      icon: PhosphorIcons.caret_left,
                      text: title),
                ),
                SystemDivider(),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(children: [
                  AspectRatio(
                      aspectRatio: 1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: FittedBox(
                                  alignment: Alignment.topLeft,
                                  fit: BoxFit.scaleDown,
                                  child: SystemText(
                                    text: "\"${ping.text}\"",
                                    font: FontEnum.garamond,
                                    size: TextSizeEnum.thirtySix,
                                  ))),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: spacingFour,
                                  vertical: spacingFour),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SystemText(
                                      text:
                                          DateFormat('EEE MMM d, yyyy · h:mma')
                                              .format(ping.time),
                                      color: gray,
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      )),
                  SystemDivider(),
                  NavigationCellCluster(title: "Metadata", children: [
                    NavigationCell(
                        onTap: () {
                          // Go to replies filter
                        },
                        label: "Replies",
                        value: "5"),
                  ]),
                  NavigationCellCluster(title: "This Ping's Time", children: [
                    PeriodOfDayNavigationCell(
                        title: "Period of Day", time: ping.time),
                    DayOfWeekNavigationCell(
                        title: "Day of Week", time: ping.time),
                    MonthNavigationCell(title: "Month", time: ping.time),
                    DayOfMonthNavigationCell(
                        title: "Day of Month", time: ping.time),
                    YearNavigationCell(title: "Year", time: ping.time),
                  ]),
                  SizedBox(height: MediaQuery.of(context).padding.bottom)
                ]))),
              ],
            )));
  }
}
