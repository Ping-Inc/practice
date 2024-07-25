import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/browse_mode_button.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/browse_enum.dart';

class BrowseModeSelector extends ConsumerWidget {
  const BrowseModeSelector({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: EdgeInsets.all(spacingTwo),
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primaryContainer,
              width: 1.5,
            ),
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(999)),
        child: Row(
          children: [
            BrowseModeButton(
                browseMode: BrowseEnum.slides, controller: controller),
            BrowseModeButton(
                browseMode: BrowseEnum.list, controller: controller),
            BrowseModeButton(
                browseMode: BrowseEnum.grid, controller: controller)
          ],
        ));
  }
}
