import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/detail_cell.dart';
import 'package:practice/components/detail_cell_cluster.dart';
import 'package:practice/components/main_spacing_cell.dart';
import 'package:practice/components/ping_action_row.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/components/repinged_cell.dart';
import 'package:practice/components/replies_grid.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/components/view_count_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/extensions/date_time_extensions.dart';
import 'package:practice/pages/traversal/traversal_mode_page.dart';
import 'package:practice/providers/never_visited_pings_provider.dart';
import 'package:practice/repositories/pings_repository.dart';
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
    _incrementViewCount();
  }

  Future<void> _incrementViewCount() async {
    await PingsRepository.incrementViewCount(widget.ping.id!);
    ref.invalidate(neverVisitedPingsProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          TopNav(
            child: SystemButton(
                onTap: () => Navigator.pop(context),
                icon: PhosphorIcons.caret_left),
          ),
          Expanded(
              child: Stack(children: [
            SingleChildScrollView(
                child: MainSpacingCell(
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
                      title: DateFormat(TimeFilterEnum.dayOfWeek.toDateFormat())
                          .format(widget.ping.time)
                          .toLowerCase(),
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TraversalModePage(
                                  inputMode: widget.ping.time.themeMode())),
                        );
                      },
                    ),
                    DetailCell(
                      title: DateFormat(TimeFilterEnum.month.toDateFormat())
                          .format(widget.ping.time)
                          .toLowerCase(),
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TraversalModePage(
                                  inputMode: widget.ping.time.themeMode())),
                        );
                      },
                    ),
                    DetailCell(
                      title:
                          DateFormat(TimeFilterEnum.dayOfMonth.toDateFormat())
                              .format(widget.ping.time)
                              .toLowerCase(),
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TraversalModePage(
                                  inputMode: widget.ping.time.themeMode())),
                        );
                      },
                    ),
                    DetailCell(
                      title: DateFormat(TimeFilterEnum.year.toDateFormat())
                          .format(widget.ping.time)
                          .toLowerCase(),
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TraversalModePage(
                                  inputMode: widget.ping.time.themeMode())),
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
                                      builder: (context) => TraversalModePage(
                                          inputMode:
                                              widget.ping.time.themeMode())),
                                );
                              },
                            ),
                          ]),
                      DetailCellCluster(title: "practice", children: [
                        ViewCountCell(pingId: widget.ping.id!),
                        RepingedCell(pingId: widget.ping.id!)
                      ]),
                    ],
                  ),
                  RepliesGrid(pingId: widget.ping.id!),
                  SizedBox(height: MediaQuery.of(context).padding.bottom)
                ]))),
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
    ));
  }
}
