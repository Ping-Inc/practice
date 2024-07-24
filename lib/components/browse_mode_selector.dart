import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/browse_mode_button.dart';
import 'package:practice/enums/browse_enum.dart';

class BrowseModeSelector extends ConsumerWidget {
  const BrowseModeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        BrowseModeButton(browseMode: BrowseEnum.slides),
        BrowseModeButton(browseMode: BrowseEnum.list),
        BrowseModeButton(browseMode: BrowseEnum.grid)
      ],
    );
  }
}
