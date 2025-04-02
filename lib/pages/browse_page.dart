import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_focus_list.dart';
import 'package:practice/components/ping_grid.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/providers/browse_provider.dart';
import 'package:practice/providers/browse_temp_provider.dart';

class BrowsePage extends ConsumerWidget {
  const BrowsePage({
    super.key,
    required this.pings,
    this.sortByResonance = false,
  });

  final List<PingData> pings;
  final bool sortByResonance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BrowseEnum browseMode =
        ref.watch(browseTempProvider) ?? ref.watch(browseProvider);

    return pings.isEmpty
        ? Center(
            child: SystemText(
            text: 'No pings match this filter',
            font: FontEnum.sfmono,
          ))
        : browseMode == BrowseEnum.focus
            ? PingFocusList(
                pings: pings,
                sortByResonance: sortByResonance,
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: spacingMedium,
                ),
                child: PingGrid(
                  pings: pings,
                  sortByResonance: sortByResonance,
                ));
  }
}
