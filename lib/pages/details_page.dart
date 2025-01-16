import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/detail_cell.dart';
import 'package:practice/components/detail_cell_cluster.dart';
import 'package:practice/components/hide_ping_button.dart';
import 'package:practice/components/main_spacing_cell.dart';
import 'package:practice/components/ping_cell_new.dart';
import 'package:practice/components/repinged_cell.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/components/traversal_shell.dart';
import 'package:practice/components/view_count_cell.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_action_image.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/extensions/filters_enum_extensions.dart';
import 'package:practice/pages/new_ping_page.dart';
import 'package:practice/providers/never_visited_pings_provider.dart';
import 'package:practice/providers/ping_provider.dart';
import 'package:practice/providers/repinged_count_provider.dart';
import 'package:practice/providers/resonated_pings_count_provider.dart';
import 'package:practice/providers/resonated_pings_provider.dart';
import 'package:practice/providers/unviewed_pings_count_provider.dart';
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
    ref.invalidate(unviewedPingsCountProvider);
    ref.invalidate(neverVisitedPingsProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(fit: StackFit.expand, children: [
      Column(
        children: [
          TopNav(
            child: SystemButton(
                onTap: () => Navigator.pop(context),
                icon: PhosphorIcons.caret_left),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: MainSpacingCell(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                PingCellNew(ping: widget.ping),
                DetailCellCluster(title: "date", children: [
                  DetailCell(
                    title: DateFormat(TimeFilterEnum.dayOfWeek.toDateFormat())
                        .format(widget.ping.time)
                        .toLowerCase(),
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TraversalShell(
                                child: FiltersEnum.day_of_month
                                    .page(widget.ping.time, false))),
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
                            builder: (context) => TraversalShell(
                                child: FiltersEnum.current_month
                                    .page(widget.ping.time, false))),
                      );
                    },
                  ),
                  DetailCell(
                    title: DateFormat(TimeFilterEnum.dayOfMonth.toDateFormat())
                        .format(widget.ping.time)
                        .toLowerCase(),
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TraversalShell(
                                child: FiltersEnum.day_of_month
                                    .page(widget.ping.time, false))),
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
                            builder: (context) => TraversalShell(
                                child: FiltersEnum.year
                                    .page(widget.ping.time, false))),
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
                                    builder: (context) => TraversalShell(
                                        child: FiltersEnum.period_of_day
                                            .page(widget.ping.time, false))),
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
                SizedBox(height: MediaQuery.of(context).padding.bottom)
              ])))),
        ],
      ),
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        MainSpacingCell(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              HidePingButton(ping: widget.ping),
              SystemActionImage(
                onTap: () {
                  ref
                      .read(pingProvider(widget.ping).notifier)
                      .increaseResonance();
                  ref.invalidate(resonatedPingsCountProvider);
                  ref.invalidate(resonatedPingsProvider);
                  ref.invalidate(repingedCountProvider(widget.ping.id!));
                },
                imagePath: 'images/icons/reping.svg',
                height: 22,
                text: 're-ping',
              ),
              SystemActionImage(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewPingPage(replyPing: widget.ping)),
                  );
                },
                imagePath: 'images/icons/reply.svg',
                text: 'reply',
                height: 18,
              ),
            ]))
      ]),
    ])));
  }
}
