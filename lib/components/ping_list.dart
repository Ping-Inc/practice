import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/main_spacing_cell.dart';
import 'package:practice/components/ping_focus_list.dart';
import 'package:practice/components/ping_grid.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/providers/browse_provider.dart';

class PingList extends ConsumerWidget {
  const PingList(
      {super.key,
      required this.scroll,
      required this.asyncPings,
      this.sliver = true});

  final VoidCallback scroll;
  final AsyncValue<List<PingData>> asyncPings;
  final bool sliver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BrowseEnum browseMode = ref.watch(browseProvider);

    return switch (asyncPings) {
      AsyncData(value: final pingsValue) => sliver
          ? browseMode == BrowseEnum.focus
              ? SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                        padding: EdgeInsets.only(top: spacingMedium),
                        child:
                            PingFocusList(pings: pingsValue, scroll: scroll)),
                  ),
                )
              : SliverPadding(
                  padding: EdgeInsets.only(
                      left: spacingMedium,
                      right: spacingMedium,
                      top: spacingSix,
                      bottom: spacingFour), // Add padding here
                  sliver:
                      PingGrid(pings: pingsValue, scroll: scroll, sliver: true))
          : browseMode == BrowseEnum.focus
              ? PingFocusList(pings: pingsValue, scroll: scroll)
              : MainSpacingCell(
                  child: PingGrid(
                      pings: pingsValue, scroll: scroll, sliver: false)),
      AsyncError() => sliver
          ? SliverToBoxAdapter(child: SystemText(text: "Error"))
          : SystemText(text: "Error"),
      _ => sliver ? SliverToBoxAdapter(child: SystemLoader()) : SystemLoader()
    };
  }
}
