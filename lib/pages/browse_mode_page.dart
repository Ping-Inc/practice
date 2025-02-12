import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/theme_mode_enum.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/mode_filtered_pings_provider.dart';

class BrowseModePage extends ConsumerWidget {
  const BrowseModePage({super.key, required this.mode});

  final ThemeModeEnum mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BrowsePage(
      asyncPings: ref.watch(modeFilteredPingsProvider(mode)),
      scroll: () => ref.read(modeFilteredPingsProvider(mode).notifier).scroll(),
    );
  }
}
