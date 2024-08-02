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
import 'package:practice/components/ping_action_row.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/providers/unviewed_pings_count_provider.dart';
import 'package:practice/repositories/pings_repository.dart';

class DetailsPage extends ConsumerStatefulWidget {
  const DetailsPage({super.key, required this.ping, required this.title});

  final Ping ping;
  final String title;

  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  @override
  void initState() {
    super.initState();
    _incrementViewCount();
  }

  Future<void> _incrementViewCount() async {
    await PingsRepository.incrementViewCount(widget.ping.id!);
    ref.invalidate(unviewedPingsCountProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                TopNav(
                  child: SystemButton(
                      onTap: () => Navigator.pop(context),
                      icon: PhosphorIcons.caret_left,
                      text: widget.title),
                ),
                SystemDivider(),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(children: [
                  AspectRatio(
                      aspectRatio: 1.0,
                      child: FittedBox(
                        alignment: Alignment.topLeft,
                        fit: BoxFit.scaleDown,
                        child: SystemText(
                          text: "\"${widget.ping.text}\"",
                          font: FontEnum.garamond,
                          size: TextSizeEnum.thirtySix,
                        ),
                      )),
                  PingActionRow(ping: widget.ping),
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
                    PeriodOfDayNavigationCell(time: widget.ping.time),
                    DayOfWeekNavigationCell(time: widget.ping.time),
                    MonthNavigationCell(time: widget.ping.time),
                    DayOfMonthNavigationCell(time: widget.ping.time),
                    YearNavigationCell(time: widget.ping.time),
                  ]),
                  SizedBox(height: spacingFour),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: spacingFour, vertical: spacingFour),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SystemText(
                              text: DateFormat('EEE MMM d, yyyy · h:mma')
                                  .format(widget.ping.time),
                              color: gray,
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: MediaQuery.of(context).padding.bottom)
                ]))),
              ],
            )));
  }
}
