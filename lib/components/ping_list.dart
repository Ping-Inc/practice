import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_focus_list.dart';
import 'package:practice/components/ping_grid.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/providers/browse_provider.dart';
import 'package:practice/providers/browse_temp_provider.dart';

class PingList extends ConsumerWidget {
  const PingList({super.key, required this.scroll, required this.asyncPings});

  final VoidCallback scroll;
  final AsyncValue<List<PingData>> asyncPings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BrowseEnum browseMode =
        ref.watch(browseTempProvider) ?? ref.watch(browseProvider);

    return switch (asyncPings) {
      AsyncData(value: final pingsValue) => pingsValue.isEmpty
          ? Center(
              child: SystemText(
              text: 'No pings match this filter',
              font: FontEnum.sfmono,
            ))
          : browseMode == BrowseEnum.focus
              ? Padding(
                  padding: EdgeInsets.only(top: spacingXSmall),
                  child: PingFocusList(pings: pingsValue, scroll: scroll))
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: spacingMedium,
                  ), // Add padding here
                  child: PingGrid(pings: pingsValue, scroll: scroll)),
      AsyncError() => SystemText(text: "Error"),
      _ => SystemLoader()
    };
  }
}
