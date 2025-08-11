import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/settings_activation_cell.dart';
import 'package:practice/providers/cached_search_setting_provider.dart';

class CachedSearchToggleCell extends ConsumerWidget {
  const CachedSearchToggleCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnabled = ref.watch(cachedSearchSettingProvider);
    
    return SettingsActivationCell(
      text: isEnabled 
        ? 'Switch back to old search provider' 
        : 'Try out new cached search provider',
      onTap: () {
        ref.read(cachedSearchSettingProvider.notifier).toggle();
      },
    );
  }
}
