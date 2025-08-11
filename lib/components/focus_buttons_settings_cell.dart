import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/settings_activation_cell.dart';
import 'package:practice/providers/hide_focus_buttons_provider.dart';

class HideFocusButtonsSettingCell extends ConsumerWidget {
  const HideFocusButtonsSettingCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hideFocusButtons = ref.watch(hideFocusButtonsProvider);
    
    return SettingsActivationCell(
      text: hideFocusButtons ? 'Show focus view action buttons' : 'Hide focus view action buttons',
      onTap: () {
        ref.read(hideFocusButtonsProvider.notifier).toggle();
      },
    );
  }
}
