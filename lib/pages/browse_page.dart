import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/browse_mode_selector.dart';
import 'package:practice/components/ping_grid.dart';
import 'package:practice/components/ping_list.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/providers/browse_provider.dart';

class BrowsePage extends ConsumerWidget {
  const BrowsePage({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final browseMode = ref.watch(browseProvider);

    return Stack(
      children: [
        if (browseMode == BrowseEnum.list) PingList(controller: controller),
        if (browseMode == BrowseEnum.grid) PingGrid(controller: controller),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: spacingFive),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [BrowseModeSelector()]))
          ],
        ),
      ],
    );
  }
}
