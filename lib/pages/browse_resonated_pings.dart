import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/resonated_pings_provider.dart';

class BrowseResonatedPingsPage extends ConsumerWidget {
  const BrowseResonatedPingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BrowsePage(
      asyncPings: ref.watch(resonatedPingsProvider),
      scroll: () => ref.read(resonatedPingsProvider.notifier).scroll(),
    );
  }
}
