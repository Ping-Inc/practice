import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/browse_enum_extensions.dart';
import 'package:practice/providers/browse_provider.dart';

class BrowseModeButton extends ConsumerWidget {
  const BrowseModeButton(
      {super.key, required this.browseMode, required this.browseController});

  final BrowseEnum browseMode;
  final PageController browseController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final browse = ref.watch(browseProvider);

    return SystemTap(
        onTap: browseController.hasClients && browse != browseMode
            ? () {
                browseController.jumpToPage(browseMode.index);
                ref.read(browseProvider.notifier).setTab(browseMode);
              }
            : null,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: spacingTwo, horizontal: spacingFive),
          decoration: BoxDecoration(
              color: browse == browseMode
                  ? Theme.of(context).colorScheme.primary
                  : null,
              borderRadius: BorderRadius.circular(999)),
          child: SystemText(
            color: browse == browseMode
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.primary,
            text: browseMode.title(),
            size: TextSizeEnum.twenty,
          ),
        ));
  }
}
