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
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/extensions/date_time_extensions.dart';
import 'package:practice/pages/traversal/traversal_day_of_month_page.dart';
import 'package:practice/pages/traversal/traversal_day_of_week_page.dart';
import 'package:practice/pages/traversal/traversal_mode_page.dart';
import 'package:practice/pages/traversal/traversal_month_page.dart';
import 'package:practice/pages/traversal/traversal_year_page.dart';
import 'package:practice/extensions/time_filter_enum_extensions.dart';
import 'package:practice/providers/pings_map_provider.dart';
import 'package:practice/providers/app_mode_provider.dart';

class DetailsPage extends ConsumerStatefulWidget {
  const DetailsPage({super.key, required this.pingId});

  final int pingId;

  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  @override
  void initState() {
    super.initState();

    // Looking at a ping in public mode doesn't count as a visit.
    if (!ref.read(isPublicModeProvider)) {
      ref.read(pingsMapProvider.notifier).incrementViewCount(widget.pingId);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Public mode is read-only: the date and time aren't links (the pages
    // they open would show private pings) and there's no action row.
    final readOnly = ref.watch(isPublicModeProvider);

    return ref.watch(pingsMapProvider).when(
          data: (map) {
            final ping = map[widget.pingId];

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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PingCell(
                                          inputPing: ping!,
                                          tappable: false,
                                        ),
                                        DetailCellCluster(
                                            title: "date",
                                            children: [
                                              DetailCell(
                                                title: DateFormat(TimeFilterEnum
                                                        .dayOfWeek
                                                        .toDateFormat())
                                                    .format(ping.time)
                                                    .toLowerCase(),
                                                onClick: readOnly ? null : () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TraversalDayOfWeekPage(
                                                                time:
                                                                    ping.time)),
                                                  );
                                                },
                                              ),
                                              DetailCell(
                                                title: DateFormat(TimeFilterEnum
                                                        .month
                                                        .toDateFormat())
                                                    .format(ping.time)
                                                    .toLowerCase(),
                                                onClick: readOnly ? null : () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TraversalMonthPage(
                                                                time:
                                                                    ping.time)),
                                                  );
                                                },
                                              ),
                                              DetailCell(
                                                title: DateFormat(TimeFilterEnum
                                                        .dayOfMonth
                                                        .toDateFormat())
                                                    .format(ping.time)
                                                    .toLowerCase(),
                                                onClick: readOnly ? null : () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TraversalDayOfMonthPage(
                                                                time:
                                                                    ping.time)),
                                                  );
                                                },
                                              ),
                                              DetailCell(
                                                title: DateFormat(TimeFilterEnum
                                                        .year
                                                        .toDateFormat())
                                                    .format(ping.time)
                                                    .toLowerCase(),
                                                onClick: readOnly ? null : () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TraversalYearPage(
                                                                year: ping.time
                                                                    .year)),
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
                                                        .format(ping.time)
                                                        .toLowerCase(),
                                                    onClick: readOnly ? null : () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TraversalModePage(
                                                                    inputMode: ping
                                                                        .time
                                                                        .themeMode())),
                                                      );
                                                    },
                                                  ),
                                                ]),
                                            DetailCellCluster(
                                                title: "practice",
                                                children: [
                                                  ViewCountCell(
                                                      pingId: ping.id!),
                                                  RepingedCell(pingId: ping.id!)
                                                ]),
                                          ],
                                        ),
                                        RepliesGrid(pingId: ping.id!),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .padding
                                                .bottom)
                                      ])))),
                      Fade(),
                    ])),
                    if (!readOnly)
                      Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Padding(
                              padding: EdgeInsets.only(top: spacingFour),
                              child: MainSpacingCell(
                                  bottomPadding: true,
                                  child: PingActionRow(ping: ping))))
                  ],
                ),
                Fade(
                  topDown: true,
                ),
                HeaderMin(),
              ]),
            ));
          },
          loading: () => Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => Scaffold(
            body: Center(child: SystemText(text: "Error loading ping")),
          ),
        );
  }
}
