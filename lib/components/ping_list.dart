import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/ping_provider.dart';

class PingList extends ConsumerWidget {
  const PingList({super.key, required this.scroll, required this.asyncPings});

  final VoidCallback scroll;
  final AsyncValue<List<PingData>> asyncPings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (asyncPings) {
      AsyncData(value: final pingsValue) => SliverPadding(
          padding: EdgeInsets.only(
              left: spacingFour,
              right: spacingFour,
              top: spacingSix,
              bottom: spacingFour +
                  MediaQuery.of(context).padding.bottom), // Add padding here
          sliver: SliverList.separated(
              itemCount: pingsValue.length,
              separatorBuilder: (context, index) => SizedBox(
                    height: spacingThree,
                  ),
              itemBuilder: (context, i) {
                final ping = ref.watch(pingProvider(pingsValue[i]));

                if (i == pingsValue.length - 1 &&
                    pingsValue.length % fetchLimit == 0) {
                  scroll();
                }

                return PingCell(ping: ping);
              })),
      AsyncError() => SliverToBoxAdapter(child: SystemText(text: "Error")),
      _ => SliverToBoxAdapter(child: SystemLoader())
    };
  }
}
