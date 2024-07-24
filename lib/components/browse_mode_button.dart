import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/extensions/browse_enum_extensions.dart';
import 'package:practice/providers/browse_provider.dart';

class BrowseModeButton extends ConsumerWidget {
  const BrowseModeButton({super.key, required this.browseMode});

  final BrowseEnum browseMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final browse = ref.watch(browseProvider);

    return SystemTap(
        onTap: () => ref.read(browseProvider.notifier).setTab(browseMode),
        child: Container(
          decoration: BoxDecoration(
            color: browse == browseMode ? Colors.blue : gray,
          ),
          child: SystemText(text: browseMode.title()),
        ));
  }
}
