import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/main_spacing_cell.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/providers/ping_provider.dart';

class PingList extends ConsumerWidget {
  const PingList(
      {super.key,
      required this.scroll,
      required this.asyncPings,
      this.sliver = true});

  final VoidCallback scroll;
  final AsyncValue<List<PingData>> asyncPings;
  final bool sliver;

  bool showHeader(List<DateTime> headeredDays, DateTime pingDateDetailed) {
    final pingDate = DateTime(
        pingDateDetailed.year, pingDateDetailed.month, pingDateDetailed.day);

    for (final date in headeredDays) {
      if (date.year == pingDate.year && date.day == pingDate.day) {
        return false;
      }
    }

    headeredDays.add(pingDate);
    return true;
  }

  String getHeader(DateTime pingDate) {
    final now = DateTime.now();
    final difference = now.difference(pingDate).inDays;

    if (difference == 0) {
      return "Today";
    } else if (difference == 1) {
      return "Yesterday";
    } else {
      return "$difference days ago";
    }
  }

  Widget pingCell(PingData ping, bool showHeader) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
            padding: EdgeInsets.only(
                bottom: spacingFour, top: showHeader ? spacingFour : 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (showHeader)
                  SystemText(
                      size: TextSizeEnum.twenty, text: getHeader(ping.time)),
                Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                      SystemText(
                          size: TextSizeEnum.twelve,
                          text: DateFormat('h:mm a').format(ping.time))
                    ])),
              ],
            )),
        PingCell(ping: ping)
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<DateTime> headeredDays = List.empty(growable: true);

    return switch (asyncPings) {
      AsyncData(value: final pingsValue) => sliver
          ? SliverPadding(
              padding: EdgeInsets.only(
                  left: spacingMedium,
                  right: spacingMedium,
                  top: spacingSix,
                  bottom: spacingFour), // Add padding here
              sliver: SliverList.separated(
                  itemCount: pingsValue.length,
                  separatorBuilder: (context, index) => SizedBox(
                        height: spacingFour,
                      ),
                  itemBuilder: (context, i) {
                    final ping = ref.watch(pingProvider(pingsValue[i]));
                    final show = showHeader(headeredDays, ping.time);

                    if (i == pingsValue.length - 1 &&
                        pingsValue.length % fetchLimit == 0) {
                      scroll();
                    }

                    return pingCell(ping, show);
                  }))
          : MainSpacingCell(
              child: ListView.separated(
                  itemCount: pingsValue.length,
                  separatorBuilder: (context, index) => SizedBox(
                        height: spacingThree,
                      ),
                  itemBuilder: (context, i) {
                    final ping = ref.watch(pingProvider(pingsValue[i]));
                    final show = showHeader(headeredDays, ping.time);

                    if (i == pingsValue.length - 1 &&
                        pingsValue.length % fetchLimit == 0) {
                      scroll();
                    }

                    return pingCell(ping, show);
                  })),
      AsyncError() => sliver
          ? SliverToBoxAdapter(child: SystemText(text: "Error"))
          : SystemText(text: "Error"),
      _ => sliver ? SliverToBoxAdapter(child: SystemLoader()) : SystemLoader()
    };
  }
}
