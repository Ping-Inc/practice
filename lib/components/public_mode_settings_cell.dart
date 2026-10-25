import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/settings_activation_cell.dart';
import 'package:practice/providers/feature_flags_provider.dart';

class PublicModeSettingCell extends ConsumerWidget {
  const PublicModeSettingCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnabled = ref.watch(publicModeEnabledProvider);

    return SettingsActivationCell(
      text: isEnabled
          ? 'Turn off Public mode (experimental)'
          : 'Try out Public mode (experimental)',
      onTap: () {
        ref.read(publicModeEnabledProvider.notifier).toggle();
      },
    );
  }
}
