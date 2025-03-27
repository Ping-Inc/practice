import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/derived_pings_providers.dart';

class BrowseResonatedPingsPage extends ConsumerWidget {
  const BrowseResonatedPingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BrowsePage(
      pings: ref.watch(resonatedPingsProvider),
      sortByResonance: true,
    );
  }
}
