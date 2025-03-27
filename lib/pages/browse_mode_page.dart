import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/derived_pings_providers.dart';

class BrowseModePage extends ConsumerWidget {
  const BrowseModePage({super.key, required this.mode});

  final String mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BrowsePage(pings: ref.watch(modeFilteredPingsProvider(mode)));
  }
}
