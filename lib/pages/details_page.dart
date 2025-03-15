import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/detail_cell.dart';
import 'package:practice/components/detail_cell_cluster.dart';
import 'package:practice/components/fade.dart';
import 'package:practice/components/header_min.dart';
import 'package:practice/components/main_spacing_cell.dart';
import 'package:practice/components/ping_action_row.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/components/repinged_cell.dart';
import 'package:practice/components/replies_grid.dart';
import 'package:practice/components/view_count_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/extensions/date_time_extensions.dart';
import 'package:practice/pages/traversal/traversal_day_of_month_page.dart';
import 'package:practice/pages/traversal/traversal_day_of_week_page.dart';
import 'package:practice/pages/traversal/traversal_mode_page.dart';
import 'package:practice/pages/traversal/traversal_month_page.dart';
import 'package:practice/pages/traversal/traversal_year_page.dart';
import 'package:practice/providers/view_count_provider.dart';
import 'package:practice/extensions/time_filter_enum_extensions.dart';

class DetailsPage extends ConsumerStatefulWidget {
  const DetailsPage({super.key, required this.ping});

  final PingData ping;

  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  @override
  void initState() {
    super.initState();

    ref.read(viewCountProvider(widget.ping.id!).notifier).incrementViewCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        Column(
          children: [
            Expanded(
                child: Stack(children: [
              SingleChildScrollView(
                  child: MainSpacingCell(
                      child: Padding(
                          padding: EdgeInsets.only(top: 70),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PingCell(
                                  inputPing: widget.ping,
                                  showId: true,
                                  tappable: false,
                                ),
                                DetailCellCluster(title: "date", children: [
                                  DetailCell(
                                    title: DateFormat(TimeFilterEnum.dayOfWeek
                                            .toDateFormat())
                                        .format(widget.ping.time)
                                        .toLowerCase(),
                                    onClick: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TraversalDayOfWeekPage(
                                                    dayOfWeek: widget
                                                        .ping.time.weekday)),
                                      );
                                    },
                                  ),
                                  DetailCell(
                                    title: DateFormat(
                                            TimeFilterEnum.month.toDateFormat())
                                        .format(widget.ping.time)
                                        .toLowerCase(),
                                    onClick: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TraversalMonthPage(
                                                    month: widget
                                                        .ping.time.month)),
                                      );
                                    },
                                  ),
                                  DetailCell(
                                    title: DateFormat(TimeFilterEnum.dayOfMonth
                                            .toDateFormat())
                                        .format(widget.ping.time)
                                        .toLowerCase(),
                                    onClick: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TraversalDayOfMonthPage(
                                                    dayOfMonth:
                                                        widget.ping.time.day)),
                                      );
                                    },
                                  ),
                                  DetailCell(
                                    title: DateFormat(
                                            TimeFilterEnum.year.toDateFormat())
                                        .format(widget.ping.time)
                                        .toLowerCase(),
                                    onClick: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TraversalYearPage(
                                                    year:
                                                        widget.ping.time.year)),
                                      );
                                    },
                                  )
                                ]),
                                Row(
                                  children: [
                                    DetailCellCluster(
                                        rightPadding: true,
                                        title: "time",
                                        children: [
                                          DetailCell(
                                            title: DateFormat('h:mm a')
                                                .format(widget.ping.time)
                                                .toLowerCase(),
                                            onClick: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TraversalModePage(
                                                            inputMode: widget
                                                                .ping.time
                                                                .themeMode())),
                                              );
                                            },
                                          ),
                                        ]),
                                    DetailCellCluster(
                                        title: "practice",
                                        children: [
                                          ViewCountCell(
                                              pingId: widget.ping.id!),
                                          RepingedCell(pingId: widget.ping.id!)
                                        ]),
                                  ],
                                ),
                                RepliesGrid(pingId: widget.ping.id!),
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).padding.bottom)
                              ])))),
              Fade(),
            ])),
            Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                    padding: EdgeInsets.only(top: spacingFour),
                    child: MainSpacingCell(
                        bottomPadding: true,
                        child: PingActionRow(ping: widget.ping))))
          ],
        ),
        Fade(
          topDown: true,
        ),
        HeaderMin(),
      ]),
    ));
  }
}
