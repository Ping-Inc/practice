import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/focus_grid_zoom.dart';
import 'package:practice/components/ping_focus_list.dart';
import 'package:practice/components/ping_grid.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/lens_date.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/providers/app_mode_provider.dart';

class BrowsePage extends ConsumerWidget {
  const BrowsePage({
    super.key,
    required this.pings,
    this.lensDate = LensDate.captured,
  });

  final List<PingData> pings;
  final LensDate lensDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (pings.isEmpty) {
      return Center(
          child: SystemText(
        text: ref.watch(isPublicModeProvider)
            ? 'No Pings are public yet.'
            : 'No pings match this filter',
        font: FontEnum.sfmono,
      ));
    }

    // Turning the dial zooms between focus and grid.
    return FocusGridZoom(
      focus: (context) => PingFocusList(
        pings: pings,
        lensDate: lensDate,
      ),
      grid: (context) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: spacingMedium,
          ),
          child: PingGrid(
            pings: pings,
            lensDate: lensDate,
            shouldRetainScrollPosition: false,
          )),
    );
  }
}
