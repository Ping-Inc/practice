import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/browse_page.dart';
import 'package:practice/providers/never_visited_pings_provider.dart';

class BrowseNeverVisitedPage extends ConsumerWidget {
  const BrowseNeverVisitedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BrowsePage(asyncPings: ref.watch(neverVisitedPingsProvider));
  }
}
