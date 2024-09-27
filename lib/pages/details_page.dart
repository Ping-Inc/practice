import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/detail_cell.dart';
import 'package:practice/components/detail_cell_cluster.dart';
import 'package:practice/components/hide_ping_button.dart';
import 'package:practice/components/ping_background.dart';
import 'package:practice/components/repinged_cell.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/components/view_count_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_action_icon.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/pages/new_ping_page.dart';
import 'package:practice/providers/never_visited_pings_provider.dart';
import 'package:practice/providers/ping_provider.dart';
import 'package:practice/providers/repinged_count_provider.dart';
import 'package:practice/providers/resonated_pings_count_provider.dart';
import 'package:practice/providers/resonated_pings_provider.dart';
import 'package:practice/providers/unviewed_pings_count_provider.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:practice/extensions/time_filter_enum_extensions.dart';
import 'package:practice/extensions/date_time_extensions.dart';
import 'package:practice/extensions/theme_mode_enum_extensions.dart';
import 'package:share_plus/share_plus.dart';

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

  Future<void> _randomPage() async {
    final pingData = await PingsRepository.fetchRandom();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailsPage(ping: PingData.fromJson(pingData))),
    );

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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                Row(mainAxisSize: MainAxisSize.max, children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(spacingFour),
                    child: PingBackground(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: spacingFour, horizontal: spacingFive),
                            child: SystemText(
                              text: widget.ping.text,
                              font: FontEnum.garamond,
                              size: TextSizeEnum.twentyNine,
                            ))),
                  ))
                ]),
                DetailCellCluster(title: "DATE", children: [
                  DetailCell(
                    title: DateFormat(TimeFilterEnum.dayOfWeek.toDateFormat())
                        .format(widget.ping.time),
                    onClick: () {},
                  ),
                  DetailCell(
                    title: DateFormat(TimeFilterEnum.month.toDateFormat())
                        .format(widget.ping.time),
                    onClick: () {},
                  ),
                  DetailCell(
                    title: DateFormat(TimeFilterEnum.dayOfMonth.toDateFormat())
                        .format(widget.ping.time),
                    onClick: () {},
                  ),
                  DetailCell(
                    title: DateFormat(TimeFilterEnum.year.toDateFormat())
                        .format(widget.ping.time),
                    onClick: () {},
                  )
                ]),
                DetailCellCluster(title: "TIME", children: [
                  DetailCell(
                    title: widget.ping.time.themeMode().toTitle(),
                    onClick: () {},
                  ),
                ]),
                DetailCellCluster(title: "PRACTICE", children: [
                  ViewCountCell(pingId: widget.ping.id!),
                  RepingedCell(pingId: widget.ping.id!)
                ]),
                SizedBox(height: MediaQuery.of(context).padding.bottom)
              ]))),
        ],
      ),
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Padding(
          padding: EdgeInsets.all(spacingFive),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: spacingSix,
            children: [
              SystemActionIcon(
                onTap: () {
                  Share.share(widget.ping.text); // Share the text
                },
                icon: PhosphorIcons.share,
                text: 'share',
              ),
              SystemActionIcon(
                onTap: () {
                  ref
                      .read(pingProvider(widget.ping).notifier)
                      .increaseResonance();
                  ref.invalidate(resonatedPingsCountProvider);
                  ref.invalidate(resonatedPingsProvider);
                  ref.invalidate(repingedCountProvider(widget.ping.id!));
                },
                icon: PhosphorIcons.sun,
                text: 're-ping',
              ),
              SystemActionIcon(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewPingPage(replyPing: widget.ping)),
                  );
                },
                icon: PhosphorIcons.arrow_arc_right,
                text: 'respond',
              ),
              HidePingButton(ping: widget.ping),
              SystemActionIcon(
                onTap: () {
                  _randomPage();
                },
                icon: PhosphorIcons.dice_four,
                text: 'random',
              ),
            ],
          ),
        )
      ]),
    ])));
  }
}
