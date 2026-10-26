import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/main_spacing_cell.dart';
import 'package:practice/components/nav_cell_cluster.dart';
import 'package:practice/components/page_with_header.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/utils/public_mode_switch.dart';

/// Settings while in public mode: only the way back to private mode.
class PublicModeSettingsPage extends ConsumerWidget {
  const PublicModeSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: PageWithHeader(
          title: 'Settings',
          child: MainSpacingCell(
            bottomPadding: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavCellCluster(text: 'Public', children: [
                  SystemTap(
                    onTap: () => returnToPrivateMode(context, ref),
                    child: Semantics(
                      button: true,
                      label: 'Public mode, on. Return to Private mode',
                      excludeSemantics: true,
                      child: Padding(
                        padding: EdgeInsets.all(spacingFive),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SystemText(text: 'Public mode'),
                            Row(children: [
                              SystemText(text: 'On'),
                              SizedBox(width: spacingFive),
                              Icon(PhosphorIcons.lock,
                                  color:
                                      Theme.of(context).colorScheme.primary),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: spacingSmall),
                SystemText(
                  text: 'To re-enter Private mode, you will be required to '
                      'enter a passcode.',
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
